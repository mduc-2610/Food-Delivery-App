import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/dialogs/show_confirm_dialog.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/deliverer/home/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:food_delivery_app/utils/helpers/map_functions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryController extends GetxController {
  static DeliveryController get instance => Get.find();

  final delivererHomeController = DelivererHomeController.instance;
  late GoogleMapController _mapController;

  @override
  void onInit() {
    super.onInit();
  }

  void onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    await delivererHomeController.initializeMarkersAndRoute();
  }

  void handleDecline(DeliveryRequest? deliveryRequest) {
    final Delivery? delivery = deliveryRequest?.delivery;
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

  void handleAccept(DeliveryRequest? deliveryRequest) {
    final Delivery? delivery = deliveryRequest?.delivery;
    delivererHomeController.trackingStage.value = 0;
    showConfirmDialog(
        Get.context!,
        title: "Are you sure ?",
        description: "Please check the route carefully",
        onAccept: () async {
          if(deliveryRequest?.accept != null) {
            final [statusCode, headers, data] = await APIService<DeliveryRequest>(fullUrl: deliveryRequest?.accept ?? "")
                .create({}, noBearer: true);
            $print(data?.status);
          }
          await delivererHomeController.addMarkers(deliveryRequest, isCheckRoute: false);
          Get.back();
        }
    );
    delivererHomeController.isOccupied.value = true;
  }

  void handleCheckRoute(DeliveryRequest? deliveryRequest) async {
    await delivererHomeController.addMarkers(deliveryRequest, isCheckRoute: true);
    Get.back();
  }

  void handleCompleteOrder(Delivery? delivery) async {
    delivererHomeController.trackingStage.value = 0;
  }

  @override
  void onClose() {
    super.onClose();
  }
}