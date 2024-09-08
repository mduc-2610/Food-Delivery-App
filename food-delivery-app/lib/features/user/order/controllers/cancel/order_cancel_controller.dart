
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/order/controllers/history/order_history_detail_controller.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderCancelController extends GetxController {
  static OrderCancelController get instance => Get.find();
  final orderHistoryDetailController = OrderHistoryDetailController.instance;

  User? user;
  Order? order;
  dynamic restaurant;

  int selectedMethod = -1;
  bool displayOtherReason = false;
  final TextEditingController otherReasonController = TextEditingController();

  final List<Map<String, dynamic>> cancelList = THardCode.getCancelList();

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    user = await UserService.getUser();
    order = orderHistoryDetailController.order;
    restaurant = order?.cart.restaurant;

    final cancellation = order?.cancellation;
    if (cancellation != null) {
      selectedMethod = cancelList.indexWhere((element) => element["type"] == cancellation.reason);
      if(selectedMethod == cancelList.length - 1 || selectedMethod == -1) {
        otherReasonController.text = order?.cancellation?.reason;
        $print("YES");
        selectedMethod = cancelList.length - 1;
        displayOtherReason = true;
      }
    }
    update();
  }

  void updateSelectedMethod(int? value) {
    if (selectedMethod == value) {
      selectedMethod = -1;
    } else {
      selectedMethod = value!;
    }

    if (selectedMethod == cancelList.length - 1) {
      displayOtherReason = !displayOtherReason;
    } else {
      displayOtherReason = false;
    }

    update();
  }

  bool get isSubmitEnabled {
    return selectedMethod != -1 &&
        (selectedMethod != cancelList.length - 1 || otherReasonController.text.isNotEmpty);
  }

  Future<void> handleSubmit() async {
    final String reason = selectedMethod != -1 && selectedMethod != cancelList.length - 1
        ? cancelList[selectedMethod]["type"]
        : otherReasonController.text;

    final orderCancellationData = OrderCancellation(
      user: user?.id,
      order: order?.id,
      restaurant: restaurant is String ? restaurant : restaurant?.id,
      reason: reason,
    );

    if (order?.cancellation == null) {
      final [statusCode, headers, data] = await APIService<OrderCancellation>().create(
        orderCancellationData,
        noBearer: true,
      );
      $print(data);
    } else {
      $print("$orderCancellationData");
      final [statusCode, headers, data] = await APIService<OrderCancellation>().update(
        order?.cancellation?.order,
        orderCancellationData.toJson(),
        noBearer: true,
      );
      $print(data);
    }
  }

  @override
  void onClose() {
    otherReasonController.dispose();
    super.onClose();
  }
}
