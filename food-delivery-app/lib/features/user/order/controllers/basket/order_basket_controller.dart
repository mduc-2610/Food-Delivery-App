
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

class OrderBasketController extends GetxController {
  static OrderBasketController get instance => Get.find();
  final restaurantDetailController = RestaurantDetailController.instance;
  final foodListController = FoodListController.instance;

  Rx<bool> isLoading = true.obs;
  Order? order;
  @override
  void onInit() {
    super.onInit();
    initializeUser();
  }

  Future<void> initializeUser() async {
    final [statusCode, headers, response] = await APIService<Order>().create({
      'cart': restaurantDetailController.user?.restaurantCart?.id
    }, );
    if(statusCode == 200 || statusCode == 201) {
      order = response;
    }
    else {
      order = await APIService<Order>().retrieve(restaurantDetailController.user?.restaurantCart?.id ?? "");
      update();
    }

    foodListController.order.value = order;
    $print("CHECK: ${foodListController.order.value}");
    Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();

  }

}
