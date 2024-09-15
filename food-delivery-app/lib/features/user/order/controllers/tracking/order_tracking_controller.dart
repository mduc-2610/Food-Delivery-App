import 'dart:async';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/dialogs/show_success_dialog.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/data/socket_services/socket_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/emojis.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
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
  Delivery? currentDelivery;
  DeliveryRequest? currentDeliveryRequest;
  Timer? movementTimer;
  int polylineIndex = 0;

  @override
  void onInit() {
    super.onInit();
    orderSocket = SocketService<Order>(handleIncomingMessage: handleIncomingMessage);
    orderSocket.connect();
    initialize();
  }

  void stopTracking() {
    try {
      orderSocket.disconnect();
      delivererSocket?.disconnect();
    } catch (e) {
      print("Error disconnecting sockets: $e");
    }
  }

  @override
  void onClose() {
    stopTracking();
    super.onClose();
  }

  Future<void> initialize() async {
    user = await UserService.getUser();
    $print(Get.arguments);
    if (Get.arguments['id'] != null) {
      currentDelivery = await APIService<Delivery>().retrieve(Get.arguments['id'] ?? '');
      $print("CHECK DELIVERER: ${currentDelivery?.deliverer}");
      if(currentDelivery?.status == "DELIVERED") {
        showSuccessDialog(
            Get.context!,
            accept: "Get back",
            title: "Successfully delivered ${TEmoji.smilingFaceWithHeart}",
            description: "Enjoy your meal ${TEmoji.faceSavoringFood}",
            image: TImage.diaConfetti,
            canPop: false,
            onAccept: () async {
              // if(currentDeliveryRequest != null) {
              //   final [statusCode, headers, data] = await APIService<DeliveryRequest>(
              //       fullUrl: currentDeliveryRequest?.complete ?? "").create({}, noBearer: true);
              //   $print(data?.delivery);
              //   $print(data?.delivery?.order);
              // }
              // else {
              //   $print("NO UPDATE");
              // }
              Get.back();
            }
        );
      }
      else if (currentDelivery?.deliverer != null) {
        delivererSocket = SocketService<Deliverer>(handleIncomingMessage: delivererIncomingMessage);
        delivererSocket?.connect(id: currentDelivery?.deliverer);
        deliverer.value = await APIService<Deliverer>().retrieve(currentDelivery?.deliverer ?? '');
        await addMarkers(currentDelivery);
      }

    }
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();
  }

  Future<void> handleIncomingMessage(String message) async {
    $print("CUSTOM: $message");
    final decodedMessage = json.decode(message);
    if (decodedMessage["delivery_request"] != null && delivererSocket == null) {
      currentDeliveryRequest = DeliveryRequest.fromJson(decodedMessage["delivery_request"]);
      currentDelivery = currentDeliveryRequest?.delivery;
      deliverer.value = await APIService<Deliverer>().retrieve(currentDelivery?.deliverer ?? '');
      delivererSocket = SocketService<Deliverer>(handleIncomingMessage: delivererIncomingMessage);
      delivererSocket?.connect(id: currentDelivery?.deliverer);
      await addMarkers(currentDelivery);
      update();
    }
  }

  Future<void> delivererIncomingMessage(String message) async {
    $print("WAS CALLED");
    try {
      final decodedMessage = json.decode(message);
      if (decodedMessage != null && decodedMessage["message"] != null) {
        final messageData = decodedMessage["message"];
        final _trackingStage = decodedMessage["tracking_stage"];
        $print("TRACKING STAGE ${decodedMessage["tracking_stage"]}");
        if (messageData["coordinate"] != null) {
          final newLatitude = messageData["coordinate"][0];
          final newLongitude = messageData["coordinate"][1];
          LatLng newDelivererPosition = LatLng(newLatitude, newLongitude);

          if (deliverer.value != null) {
            deliverer.value?.currentCoordinate = newDelivererPosition;
          }
          TMapFunction.updateMarkerCoordinate(markers: markers, coordinate: newDelivererPosition);
          trackingStage.value = _trackingStage;
          markers.refresh();

          startMovingMarkerAlongRoute(currentDelivery, deliverer.value?.currentCoordinate ?? newDelivererPosition);
          TMapFunction.animateCamera(_mapController, deliverer.value?.currentCoordinate ?? newDelivererPosition, newDelivererPosition);
          update();
        }
      }
    } catch (e) {
      print("Error handling deliverer incoming message: $e");
    }
  }
  //
  // Future<void> reconnectSockets() async {
  //   if (!orderSocket.isConnected) {
  //     orderSocket.connect();
  //   }
  //   if (delivererSocket != null) {
  //     delivererSocket?.connect(id: delivery?.deliverer);
  //   }
  // }

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
    if (delivery == null) return;

    await TMapFunction.createMarker(
        'pick_up',
        avatar: "https://th.bing.com/th/id/OIP.J7Td_S41uQvsuGI73Pu5dwHaH_?rs=1&pid=ImgDetMain",
        size: 120,
        borderColor: TColor.secondary,
        borderWidth: 0,
        coordinate: delivery.pickupCoordinate,
        markers: markers
    );

    if (deliverer.value != null && deliverer.value?.currentCoordinate != null) {
      await TMapFunction.createMarker(
          'current',
          avatar: deliverer.value?.avatar,
          size: 150,
          borderColor: Colors.blue,
          borderWidth: 0,
          coordinate: deliverer.value?.currentCoordinate,
          markers: markers
      );
    }

    markers.refresh();
    if (delivery.dropOffCoordinate != null) {
      polylineCoordinates.value = await TMapFunction.getPolyCoordinates([
        deliverer.value?.currentCoordinate ?? LatLng(0, 0),
        delivery.pickupCoordinate ?? LatLng(0, 0),
        delivery.dropOffCoordinate ?? LatLng(0, 0),
      ]);
      TMapFunction.updatePolylineColor(
          polylines: polylines,
          index: 0,
          coordinates: polylineCoordinates
      );
    }
    update();
  }

  void startMovingMarkerAlongRoute(Delivery? delivery, LatLng newPosition) async {
    if (polylineCoordinates.isEmpty) return;
    if (delivery == null) return;

    LatLng currentPoint = newPosition;


    if (trackingStage.value == 3) {
      showSuccessDialog(
          Get.context!,
          accept: "Get back",
          title: "Successfully delivered ${TEmoji.smilingFaceWithHeart}",
          description: "Enjoy your meal ${TEmoji.faceSavoringFood}",
          image: TImage.diaConfetti,
          canPop: false,
          onAccept: () async {
            // if(currentDeliveryRequest != null) {
            //   final [statusCode, headers, data] = await APIService<DeliveryRequest>(
            //       fullUrl: currentDeliveryRequest?.complete ?? "").create({}, noBearer: true);
            //   $print(data?.delivery);
            //   $print(data?.delivery?.order);
            // }
            // else {
            //   $print("NO UPDATE");
            // }
            Get.back();
          }
      );
    }

    int index = polylineCoordinates.indexWhere((coordinate) => coordinate == currentPoint);
    $print("CHECK1");
    if (index != -1) {
      $print("CHECK2");
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
