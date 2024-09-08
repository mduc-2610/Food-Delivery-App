import 'dart:async';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/data/socket_services/socket_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:food_delivery_app/utils/helpers/map_functions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingController extends GetxController {
  static OrderTrackingController get instance => Get.find();

  late GoogleMapController _mapController;

  late SocketService orderSocket;
  SocketService? delivererSocket;

  Rx<int> trackingStage = 0.obs;
  Rx<bool> isLoading = true.obs;
  Rx<LatLng> currentPosition = LatLng(0, 0).obs;
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  Rx<Deliverer?> deliverer = (null as Deliverer?).obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  RxSet<Polyline> polylines = <Polyline>{}.obs;

  User? user;
  Order? order;
  String? delivererId;
  Delivery? delivery;
  Timer? movementTimer;
  int polylineIndex = 0;

  @override
  void onInit() {
    super.onInit();
    orderSocket = SocketService<Order>(handleIncomingMessage: handleIncomingMessage);
    orderSocket.connect();
    initialize();
  }

  Future<void> handleIncomingMessage(String message) async {
    $print("CUSTOM: $message");
    final decodedMessage = json.decode(message);
    if(decodedMessage["delivery"] != null) {
      if(delivery == null) {
        delivery = Delivery.fromJson(decodedMessage["delivery"]);
      }
      else {
        $print("HAVE init");
      }
      deliverer.value = await APIService<Deliverer>().retrieve(delivery?.deliverer ?? '');
      delivererSocket = SocketService<Deliverer>(handleIncomingMessage: delivererIncomingMessage);
      delivererSocket?.connect(id: delivery?.deliverer);
      await addMarkers(delivery);
      update();
    }
  }

  Future<void> delivererIncomingMessage(String message) async {
    try {
      final decodedMessage = json.decode(message);
      $print("DUC: ${decodedMessage}");
      if (decodedMessage != null && decodedMessage["message"] != null) {
        final [newLatitude, newLongitude] = decodedMessage["message"]["coordinate"];

        LatLng newDelivererPosition = LatLng(newLatitude, newLongitude);
        deliverer.value?.currentCoordinate = newDelivererPosition;

        TMapFunction.updateMarkerCoordinate(markers: markers, coordinate: newDelivererPosition);
        markers.refresh();

        startMovingMarkerAlongRoute(delivery, newDelivererPosition);
        TMapFunction.animateCamera(_mapController, newDelivererPosition, newDelivererPosition);

        update();
      }
    } catch (e) {
      print("Error handling deliverer incoming message: $e");
    }
  }


  Future<void> initialize() async {
    user = await UserService.getUser();
    if(Get.arguments['id'] != null) {
      delivery = await APIService<Delivery>().retrieve(Get.arguments['id'] ?? '');
    }
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();
  }

  void stopTracking() {
    orderSocket.disconnect();
    delivererSocket?.disconnect();
  }

  @override
  void onClose() {
    stopTracking();
    super.onClose();
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    await TMapFunction.createMarker(
      'drop_off',
      avatar: user?.profile?.avatar,
      size: 120,
      borderColor: TColor.primary,
      borderWidth: 0,
      coordinate: user?.selectedLocation?.currentCoordinate,
      markers: markers
    );
    update();
  }


  Future<void> addMarkers(Delivery? delivery) async {
    await TMapFunction.createMarker(
        'pick_up',
        avatar: "https://th.bing.com/th/id/OIP.J7Td_S41uQvsuGI73Pu5dwHaH_?rs=1&pid=ImgDetMain",
        size: 120,
        borderColor: TColor.secondary,
        borderWidth: 0,
        coordinate: delivery?.pickupCoordinate,
        markers: markers
    );

    await TMapFunction.createMarker(
        'current',
        avatar: deliverer.value?.avatar,
        size: 150,
        borderColor: Colors.blue,
        borderWidth: 0,
        coordinate: deliverer.value?.currentCoordinate,
        markers: markers
    );

    markers.refresh();
    polylineCoordinates.value = await TMapFunction.getPolyCoordinates([
      deliverer.value?.currentCoordinate ?? LatLng(0, 0),
      delivery?.pickupCoordinate ?? LatLng(0, 0),
      delivery?.dropOffCoordinate ?? LatLng(0, 0),
    ]);
    update();
  }

  void startMovingMarkerAlongRoute(Delivery? delivery, LatLng newPosition) {
    if (polylineCoordinates.isEmpty) return;
    if(delivery == null) {
      return;
    }

    LatLng currentPoint = newPosition;

    if (trackingStage.value == 1 &&
        TMapFunction.isNearLocation(currentPoint, delivery.pickupCoordinate)) {
      trackingStage.value = 2;
    }

    if (trackingStage.value == 0 &&
        TMapFunction.isNearLocation(currentPoint, delivery.pickupCoordinate)) {
      trackingStage.value = 1;
    }

    if (trackingStage.value == 2 &&
        TMapFunction.isNearLocation(currentPoint, delivery.dropOffCoordinate)) {
      trackingStage.value = 3;
    }

    int index = polylineCoordinates.indexWhere((coordinate) => coordinate == currentPoint);
    if(index != -1) {
      TMapFunction.updatePolylineColor(
          polylines: polylines,
          index: index,
          coordinates: polylineCoordinates
      );
    }
    update();
  }


  void handleCancel() {
    $print("Incoming message: ${orderSocket.incomingMessage}");
  }
}
