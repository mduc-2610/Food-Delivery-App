
import 'dart:io';

import 'package:food_delivery_app/data/socket_services/socket_service.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderTrackingController extends GetxController {
  static OrderTrackingController get instance => Get.find();
  late SocketService socketService;
  Order? order;

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null) {
      order = Get.arguments['order'];
    }
    socketService = SocketService<Order>();
    socketService.connect();
    $print("CONNECT");
    socketService.add(Get.arguments);
  }

  @override
  void onClose() {
    super.onClose();
    $print("DISCONNECT");
    socketService.disconnect();
  }


}