
import 'package:get/get.dart';
import 'package:food_delivery_app/common/controllers/list/food_list_controller.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderHistoryDetailController extends GetxController {
  static OrderHistoryDetailController get instance => Get.find();
  Rx<bool> isLoading = true.obs;
  Order? order;
  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    if(Get.arguments['id'] != null) {
      order = await APIService<Order>().retrieve(Get.arguments['id']);
      $print(order);
      Future.delayed(Duration(milliseconds: TTime.init));
      isLoading.value = false;
    }
  }
}

