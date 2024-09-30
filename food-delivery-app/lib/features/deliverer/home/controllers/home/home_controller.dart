
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/deliverer_service.dart';
import 'package:food_delivery_app/data/socket_services/socket_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:food_delivery_app/utils/helpers/map_functions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class DelivererHomeController extends GetxController {
  static DelivererHomeController get instance => Get.find();

  final scrollController = ScrollController();
  var isLoading = true.obs, isLoadingHistory = false.obs;
  var isOccupied = true.obs;
  Deliverer? deliverer;
  DeliveryRequest? currentDeliveryRequest;
  BasicUser? currentUserAccepted;
  RxList<Delivery> deliveries = <Delivery>[].obs;
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
  Rx<bool> isLoadingDeliveryRequest = false.obs;
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
      initialize(loadMore: true);
      $print("$_nextPage \n ${deliveries.length}");
    }
  }

  Future<void> filterDeliveriesByDate(DateTime? date) async {
    selectedDate.value = date;

    // if (date != null) {
    //   final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    //   final [result, info] = await APIService<Delivery>(fullUrl: deliverer?.deliveries ?? '',).list();
    //   deliveries = result;
    //   _nextPage = info["next"];
    // } else {
      await initialize(loadMore: false, reset: true);

  }



  String? _nextPage, _nextPage2;
  Future<void> initialize({ bool loadMore = false, bool reset = false }) async {
    if(delivererSocket == null) {
      deliverer = await DelivererService.getDeliverer();
      isOccupied.value = deliverer?.isOccupied ?? false;
      delivererSocket = SocketService<Deliverer>(handleIncomingMessage: handleIncomingMessage);
      delivererSocket?.connect(id: deliverer?.id);
    }
    if (_nextPage != null || !loadMore) {
      if (reset) {
        isLoadingHistory.value = true;
        _nextPage = null;
        deliveries.value = [];
      }
      var url = _nextPage ?? deliverer?.deliveries ?? '';
      if (selectedDate.value != null) {
        final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value!);
        url += '${url.contains('?') ? '&' : '?'}date=$formattedDate';
      }
      var [_result, info] = await APIService<Delivery>(fullUrl: url).list(next: true);
      if (!loadMore) {
        deliveries.value = _result;
      } else {
        deliveries.addAll(_result);
      }
      _nextPage = info["next"];
      isLoadingHistory.value = false;
    }
    if(!loadMore) {
      await Future.delayed(Duration(milliseconds: TTime.init));
    }
    if(_nextPage2 != null || !loadMore) {
      var url = _nextPage2 ?? deliverer?.requests ?? '';
      var [_result, info] = await APIService<DeliveryRequest>(fullUrl: url, queryParams: "status=FINDING_DRIVER").list(next: true);
      if (!loadMore) {
        deliveryRequests.value = _result;
      } else {
        deliveryRequests.addAll(_result);
      }
      _nextPage2 = info["next"];
    }
    isLoading.value = false;
    update();
  }

  void handleIncomingMessage(String message) async {
    final decodedMessage = json.decode(message);
    $print("Message: $message");
    if(decodedMessage != null) {
      $print("FLAG: ${decodedMessage["flag"]}");
      if(decodedMessage["flag"] != null) {
        deliveryRequests.insert(0, DeliveryRequest.fromJson(decodedMessage["delivery_request"]));
        // currentDeliveryRequest = DeliveryRequest.fromJson(decodedMessage["delivery_request"]);
      }
      if(decodedMessage["delivery_request"] != null && currentDeliveryRequest == null) {
        currentDeliveryRequest = DeliveryRequest.fromJson(decodedMessage["delivery_request"]);
      }
      if (decodedMessage["message"] != null) {
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
  }

  Future<void> initializeMarkersAndRoute() async {
    markers.add(await TMapFunction.createMarker(
      'current',
      avatar: deliverer?.avatar ?? TImage.defaultAvatar,
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
      avatar: delivery?.user?.avatar ?? TImage.defaultAvatar,
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

    if (!isCheckRoute && currentDeliveryRequest != null) {
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
      if (polylineIndex.value < polylineCoordinates.length) {
      // if (polylineIndex.value == polylineCoordinates.length) index -= 1;
      LatLng currentPoint = polylineCoordinates[polylineIndex.value];

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
        timer.cancel();
        final [statusCode, headers, data] = await APIService<DeliveryRequest>(
            fullUrl: deliveryRequest?.complete ?? "").create({}, noBearer: true);
        var x = data?.delivery?.order;
        $print("COMPLETE ${x?.status} ${x?.totalPrice}");
        trackingStage.value = 3;
        delivererSocket?.add({
          'coordinate': polylineCoordinates[polylineIndex.value - 1],
          'tracking_stage': trackingStage.value,
        });

      }
    });
  }
}