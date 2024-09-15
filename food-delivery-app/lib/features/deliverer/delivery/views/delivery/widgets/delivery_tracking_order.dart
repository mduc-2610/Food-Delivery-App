import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/deliverer/delivery/controllers/delivery/delivery_controller.dart';
import 'package:food_delivery_app/features/user/order/views/tracking/widgets/order_tracking.dart';

class DeliveryTrackingOrder extends StatelessWidget {
  final DeliveryRequest? deliveryRequest;
  final DeliveryController deliveryController;

  const DeliveryTrackingOrder({
    this.deliveryRequest,
    super.key,
    required this.deliveryController,
  });

  @override
  Widget build(BuildContext context) {
    return OrderTracking(
      delivery: deliveryRequest?.delivery,
      onCancel: () {
        deliveryController.delivererHomeController.isOccupied.value = false;
        Get.back();
      },
      controller: deliveryController,
      type: OrderTrackingType.deliverer,
    );
  }
}