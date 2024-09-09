import 'package:food_delivery_app/common/widgets/dialogs/show_confirm_dialog.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/features/user/order/controllers/basket/order_basket_controller.dart';
import 'package:food_delivery_app/features/user/order/controllers/common/order_info.dart';
import 'package:food_delivery_app/features/user/order/controllers/history/order_history_detail_controller.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/features/user/order/views/location/order_location.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/features/user/order/views/cancel/order_cancel.dart';
import 'package:food_delivery_app/features/user/order/views/tracking/order_tracking.dart';


class OrderBottomNavigationBarController extends GetxController {
  var controller;
  Order? order;
  final OrderViewType viewType;

  OrderBottomNavigationBarController({this.order, required this.viewType});


  @override
  void onInit() {
    super.onInit();
    if (viewType == OrderViewType.basket) {
      controller = OrderBasketController.instance;
    } else if (viewType == OrderViewType.history) {
      controller = OrderHistoryDetailController.instance;
    }
    order = controller.order;
  }

  Future<void> reorder() async {
    if (order?.status == "COMPLETED") {
      print("Reordering...");
    }
  }

  Future<void> cancelOrder() async {
    await Get.to(() => OrderCancelView());
    await controller?.initialize();
  }

  Future<void> trackOrder(BuildContext context) async {
    if (order?.status == "ACTIVE" && order?.cancellation == null) {
      void onAccept() async {
        final [statusCode, headers, data] = await APIService<Order>(
          endpoint: 'order/order/${order?.id}/create-delivery-and-request',
        ).create({}, noBearer: true, noFromJson: true);
        final delivery = Delivery.fromJson(data["delivery"]);
        // final nearestDeliverer = Deliverer.fromJson(data["nearest_deliverer"]);
        await Get.to(() => OrderTrackingView(), arguments: {
          'id': delivery.order.id,
        });
        await controller.initialize();

      }
      onAccept();
    }
  }

  Future<void> handlePendingOrder(BuildContext context) async {
    if (order?.status == "PENDING") {
      void onAccept() async {
        final [statusCode, headers, data] = await APIService<Order>(
          endpoint: 'order/order/${order?.id}/create-delivery-and-request',
        ).create({}, noBearer: true, noFromJson: true);
        final delivery = Delivery.fromJson(data["delivery"]);
        Get.offAll(UserMenuRedirection());
        showConfirmDialog(
          context,
          title: "Successfully ordered",
          description: "You can track your order in order history",
          onAccept: () {
            Get.to(() => OrderTrackingView(), arguments: {
              'id': delivery.order.id,
            });
          },
          accept: "Check",
          decline: "Later",
          declineButtonColor: TColor.secondary
        );
      }
      showConfirmDialog(context, onAccept: onAccept,
        title: "Are you sure?",
        description: "Check the information carefully",
      );
    }
  }

  bool isCancellationPending() {
    return order?.cancellation != null && !order!.cancellation.isAccepted;
  }

  String getCancellationStatusText() {
    return order?.cancellation != null && order!.cancellation.isAccepted ? "Success" : "Waiting for response";
  }

  Future<void> onCancelOrderTapped() async {
    await Get.to(() => OrderCancelView());
    await controller?.initialize();
  }

  Future<void> deleteOrder(String? orderId) async {
    if (orderId != null) {
      await controller?.initialize();
    }
  }


  Future<void> deleteCancelRequest() async{
    showConfirmDialog(Get.context!, onAccept: () async {
      if(order?.id != null) {
        await APIService<OrderCancellation>().delete(order?.id ?? '');
        await controller?.initialize();
      }
      else {
      }

    },
      title: "Are you sure to continue the order ?",
      description: "Check information carefully",
    );
  }
}
