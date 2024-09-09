import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/common/widgets/dialogs/show_confirm_dialog.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/features/user/order/views/cancel/order_cancel.dart';
import 'package:food_delivery_app/features/user/order/views/tracking/order_tracking.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/user/order/controllers/basket/order_basket_controller.dart';
import 'package:food_delivery_app/features/user/order/controllers/history/order_history_detail_controller.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/features/user/order/views/location/order_location.dart';

enum OrderViewType { basket, history, cancel, other }

class OrderInfoController extends GetxController {
  Order? order;
  final OrderViewType viewType;

  OrderInfoController({this.order, required this.viewType});

  var controller;

  @override
  void onInit() {
    super.onInit();
    if (viewType == OrderViewType.basket) {
      controller = OrderBasketController.instance;
    } else if (viewType == OrderViewType.history) {
      controller = OrderHistoryDetailController.instance;
    }
  }

  Future<void> initializeUser() async {
    await controller?.initializeUser();
  }

  Future<void> onAddressTapped() async {
    if (viewType != OrderViewType.history) {
      await Get.to(() => OrderLocationSelectView());
      await initializeUser();
    }
  }

  Future<void> onCancelOrderTapped() async {
    await Get.to(() => OrderCancelView());
    await controller?.initialize();
  }

  Future<void> reorder() async {
    if (order?.status == "COMPLETED") {
      // Add reorder logic here
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

