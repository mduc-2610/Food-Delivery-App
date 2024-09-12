
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/deliverer_service.dart';
import 'package:food_delivery_app/data/socket_services/socket_service.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:food_delivery_app/utils/helpers/map_functions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class DelivererHomeController extends GetxController {
  static DelivererHomeController get instance => Get.find();

  final scrollController = ScrollController();
  var isLoading = true.obs;
  var isOccupied = true.obs;
  Deliverer? deliverer;
  DeliveryRequest? currentDeliveryRequest;
  List<Delivery> deliveries = [];
  RxList<DeliveryRequest> deliveryRequests = <DeliveryRequest>[].obs;
  SocketService? delivererSocket;
  Rx<LatLng?> currentCoordinate = (null as LatLng?).obs;
  Rx<int> trackingStage = 0.obs;
  Rx<int> polylineIndex = 0.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // New properties for route tracking
  RxSet<Marker> markers = <Marker>{}.obs;
  RxSet<Polyline> polylines = <Polyline>{}.obs;
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  Timer? movementTimer;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    initialize();
  }

  @override
  void onClose() {
    delivererSocket?.disconnect();
    movementTimer?.cancel();
  }

  void _scrollListener() {
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      $print(_nextPage);
      initialize(loadMore: true);
    }
  }

  Future<void> filterDeliveriesByDate(DateTime? date) async {
    selectedDate.value = date;
    isLoading.value = true;
    update();

    if (date != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final url = '${deliverer?.deliveries}/?';
      final [result, info] = await APIService<Delivery>(fullUrl: deliverer?.deliveries ?? '', queryParams: "date=$formattedDate").list();
      deliveries = result;
      _nextPage = info["next"];
    } else {
      // Reset to initial state
      await initialize(loadMore: false);
    }

    isLoading.value = false;
    update();
  }


  String? _nextPage, _nextPage2;
  Future<void> initialize({ bool loadMore = false }) async {
    deliverer = await DelivererService.getDeliverer();
    isOccupied.value = deliverer?.isOccupied ?? false;
    delivererSocket = SocketService<Deliverer>();
    delivererSocket?.connect(id: deliverer?.id);
    if (_nextPage != null || !loadMore) {
      var url = _nextPage ?? deliverer?.deliveries ?? '';
      if (selectedDate.value != null) {
        final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value!);
        url += '${url.contains('?') ? '&' : '?'}date=$formattedDate';
      }
      var [_result, info] = await APIService<Delivery>(fullUrl: url).list(next: true);
      if (!loadMore) {
        deliveries = _result;
      } else {
        deliveries.addAll(_result);
      }
      _nextPage = info["next"];
    }
    if(!loadMore) {
      await Future.delayed(Duration(milliseconds: TTime.init));
    }
    isLoading.value = false;
    update();
  }

  void handleIncomingMessage(String message) {
    final decodedMessage = json.decode(message);
    $print("Message: $message");
    if(decodedMessage != null && decodedMessage["delivery_request"] != null) {
      currentDeliveryRequest = DeliveryRequest.fromJson(decodedMessage["delivery_request"]);
    }
    if (decodedMessage != null && decodedMessage["message"] != null) {
      final messageData = decodedMessage["message"];
      final _trackingStage = decodedMessage["tracking_stage"];
      final _polylineIndex = decodedMessage["polyline_index"];
      if (_trackingStage != null) {
        trackingStage.value = _trackingStage;
      }
      if(_polylineIndex != null) {
        polylineIndex.value = _polylineIndex;
      }

      if (messageData["coordinate"] != null) {
        final newLatitude = messageData["coordinate"][0];
        final newLongitude = messageData["coordinate"][1];
        LatLng newDelivererPosition = LatLng(newLatitude, newLongitude);
        currentCoordinate.value = newDelivererPosition;
      }
    }
  }

  Future<void> initializeMarkersAndRoute() async {
    markers.add(await TMapFunction.createMarker(
      'current',
      avatar: deliverer?.avatar,
      size: 150,
      borderColor: Colors.blue,
      borderWidth: 0,
      coordinate: currentCoordinate.value ?? deliverer?.currentCoordinate,
    ));
    if (currentDeliveryRequest != null) {
      await addMarkers(currentDeliveryRequest);
      await drawRouteFromCurrentPosition();
    }
    update();
  }

  Future<void> addMarkers(DeliveryRequest? deliveryRequest, {bool isCheckRoute = false}) async {
    final Delivery? delivery = deliveryRequest?.delivery;

    markers.add(await TMapFunction.createMarker(
      'pick_up',
      avatar: "https://th.bing.com/th/id/OIP.J7Td_S41uQvsuGI73Pu5dwHaH_?rs=1&pid=ImgDetMain",
      size: 120,
      borderColor: Colors.orange,
      borderWidth: 0,
      coordinate: delivery?.pickupCoordinate,
    ));

    markers.add(await TMapFunction.createMarker(
      'drop_off',
      avatar: delivery?.user?.avatar,
      size: 120,
      borderColor: Colors.red,
      borderWidth: 0,
      coordinate: delivery?.dropOffCoordinate,
    ));

    markers.refresh();

    if (!isCheckRoute) {
      delivererSocket?.add({'delivery_request': deliveryRequest?.toJson()});
    }

    polylineCoordinates.value = await TMapFunction.getPolyCoordinates([
      deliverer?.currentCoordinate ?? LatLng(0, 0),
      delivery?.pickupCoordinate ?? LatLng(0, 0),
      delivery?.dropOffCoordinate ?? LatLng(0, 0),
    ]);

    TMapFunction.updatePolylineColor(
      polylines: polylines,
      index: 0,
      coordinates: polylineCoordinates,
    );

    if (!isCheckRoute || currentDeliveryRequest != null) {
      await startMovingMarkerAlongRoute(deliveryRequest);
    }

    update();
  }

  Future<void> drawRouteFromCurrentPosition() async {
    if (currentDeliveryRequest == null) return;

    final Delivery? delivery = currentDeliveryRequest?.delivery;

    if (delivery != null) {
      await startMovingMarkerAlongRoute(currentDeliveryRequest);
    }
  }

  Future<void> startMovingMarkerAlongRoute(DeliveryRequest? deliveryRequest) async {
    final Delivery? delivery = deliveryRequest?.delivery;
    if (polylineCoordinates.isEmpty) return;

    movementTimer?.cancel();
    movementTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) async {
      if (delivery == null) {
        timer.cancel();
        return;
      }
      int index = polylineIndex.value;
      if (polylineIndex.value == polylineCoordinates.length) index -= 1;
      LatLng currentPoint = polylineCoordinates[index];

      if (trackingStage.value == 1 &&
          TMapFunction.isNearLocation(currentPoint, delivery.pickupCoordinate!)) {
        trackingStage.value = 2;
      }

      if (trackingStage.value == 0 &&
          TMapFunction.isNearLocation(currentPoint, delivery.pickupCoordinate!)) {
        trackingStage.value = 1;
      }

      if (trackingStage.value == 2 &&
          TMapFunction.isNearLocation(currentPoint, delivery.dropOffCoordinate!)) {
        trackingStage.value = 3;
      }

      if (polylineIndex.value < polylineCoordinates.length) {
        LatLng currentLatLng = polylineCoordinates[polylineIndex.value];
        LatLng nextLatLng = polylineCoordinates[polylineIndex.value + (polylineIndex.value == polylineCoordinates.length - 1 ? 0 : 1)];

        TMapFunction.updateMarkerCoordinate(markers: markers, coordinate: currentLatLng);

        TMapFunction.updatePolylineColor(
          polylines: polylines,
          index: polylineIndex.value,
          coordinates: polylineCoordinates,
        );

        delivererSocket?.add({
          'coordinate': polylineCoordinates[polylineIndex.value],
          'tracking_stage': trackingStage.value,
        });

        currentCoordinate.value = currentLatLng;
        polylineIndex.value++;
        update();
      } else {
        final [statusCode, headers, data] = await APIService<DeliveryRequest>(
            fullUrl: deliveryRequest?.complete ?? "").create({}, noBearer: true);
        var x = data?.delivery?.order;
        $print("COMPLETE ${x?.status} ${x?.totalPrice}");
        trackingStage.value = 3;
        delivererSocket?.add({
          'coordinate': polylineCoordinates[polylineIndex.value],
          'tracking_stage': trackingStage.value,
        });

        timer.cancel();
      }
    });
  }
}