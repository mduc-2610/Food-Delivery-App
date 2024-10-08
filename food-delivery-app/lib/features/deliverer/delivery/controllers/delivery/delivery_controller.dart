import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/dialogs/show_confirm_dialog.dart';
import 'package:food_delivery_app/common/widgets/dialogs/show_success_dialog.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/deliverer/delivery/views/delivery/widgets/delivery_available_orders.dart';
import 'package:food_delivery_app/features/deliverer/delivery/views/delivery/widgets/delivery_tracking_order.dart';
import 'package:food_delivery_app/features/deliverer/home/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:food_delivery_app/utils/helpers/map_functions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryController extends GetxController {
  static DeliveryController get instance => Get.find();

  final delivererHomeController = DelivererHomeController.instance;
  late GoogleMapController _mapController;
  DeliveryRequest? curDeliveryRequest;
  Deliverer? deliverer;

  @override
  void onInit() {
    super.onInit();
    deliverer = delivererHomeController.deliverer;
  }

  void onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    curDeliveryRequest = delivererHomeController.currentDeliveryRequest;
    $print("ACCEPT USER: ${curDeliveryRequest?.delivery?.user}");
    await delivererHomeController.initializeMarkersAndRoute();
  }

  void handleDecline(DeliveryRequest? deliveryRequest) {
    final Delivery? delivery = deliveryRequest?.delivery;
    curDeliveryRequest = deliveryRequest;
    delivererHomeController.currentDeliveryRequest = curDeliveryRequest;
    delivererHomeController.trackingStage.value = 0;
    showConfirmDialog(
        Get.context!,
        title: "Are you sure ?",
        description: "This will affect your rating",
        onAccept: () async {
          var element = delivererHomeController.deliveryRequests.firstWhere((instance) => instance.delivery == delivery);
          delivererHomeController.deliveryRequests.remove(element);
          update();
        }
    );
    delivererHomeController.isOccupied.value = true;
  }

  void handleAccept(DeliveryRequest? deliveryRequest) async {
    final Delivery? delivery = deliveryRequest?.delivery;
    curDeliveryRequest = deliveryRequest;
    delivererHomeController.currentDeliveryRequest = curDeliveryRequest;
    $print("ON ACCPEPT ${delivererHomeController.currentDeliveryRequest?.user}");
    delivererHomeController.trackingStage.value = 0;
    showConfirmDialog(
        Get.context!,
        title: "Are you sure ?",
        description: "Please check the route carefully",
        onAccept: () async {
          String? orderId = (delivery?.order != null)
              ? delivery?.order is String ? delivery?.order : delivery?.order?.id
              : null;
          if(orderId == null) {
            Get.snackbar(
              "Error check",
              "Error occurred when checking order status",
              backgroundColor: TColor.errorSnackBar,
            );
            return;
          }
          try {
            final Order? order = await APIService<Order>().retrieve(orderId ?? "");
            if(order?.status == "COMPLETED" || order?.status == "CANCELLED") {
              delivererHomeController.deliveryRequests.removeWhere((request) => request.delivery == delivery);
              Get.snackbar(
                "Order cancelled",
                "This order has been ${order?.status?.toLowerCase()}. ""Please choose another",
                backgroundColor: TColor.infoSnackBar,
              );
              return;
            }
          }
          catch(e) {
            Get.snackbar("Error", "An error occurred");
            return;
          }

          delivererHomeController.deliveryRequests.removeWhere((request) => request.delivery == delivery);
          if(deliveryRequest?.accept != null) {
            final [statusCode, headers, data] = await APIService<DeliveryRequest>(fullUrl: deliveryRequest?.accept ?? "")
                .create({}, noBearer: true);
          }
          Get.back();
          await delivererHomeController.addMarkers(deliveryRequest, isCheckRoute: false);
        }
    );
    delivererHomeController.isOccupied.value = true;
  }

  void handleCheckRoute(DeliveryRequest? deliveryRequest) async {
    curDeliveryRequest = deliveryRequest;
    delivererHomeController.currentDeliveryRequest = curDeliveryRequest;
    Get.back();
    resetRoute();
    await delivererHomeController.addMarkers(deliveryRequest, isCheckRoute: true);
  }

  void handleCompleteOrder() async {
    delivererHomeController.trackingStage.value = 0;
    delivererHomeController.isOccupied.value = false;
    Get.back();
    resetRoute();
    await showSuccessDialog(
      Get.context!,
      head: "Good job",
      description: "New delivery request done",
      image: TImage.diaHeart,
      onAccept: () {}
    );
  }

  void showAvailableOrders() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      builder: (context) {
        return
          (!delivererHomeController.isOccupied.value)
              ? DeliveryAvailableOrders(deliveryController: this, context: context)
              : DeliveryTrackingOrder(deliveryController: this,
            deliveryRequest: curDeliveryRequest,);
      },
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }

  void resetRoute() async {
    delivererHomeController.polylines.clear();
    delivererHomeController.polylineCoordinates.clear();
    delivererHomeController.polylineIndex.value = 0;

    delivererHomeController.markers.clear();

    if (delivererHomeController.currentCoordinate.value != null) {
      delivererHomeController.markers.add(await TMapFunction.createMarker(
        'current',
        avatar: delivererHomeController.deliverer?.avatar ?? TImage.defaultAvatar,
        size: 150,
        borderColor: Colors.blue,
        borderWidth: 0,
        coordinate: delivererHomeController.deliverer?.currentCoordinate,
      ));
    }

    delivererHomeController.movementTimer?.cancel();

    delivererHomeController.currentDeliveryRequest = null;

    _mapController.animateCamera(CameraUpdate.newLatLng(delivererHomeController.deliverer!.currentCoordinate));

  }

  @override
  void onClose() {
    super.onClose();
  }
}