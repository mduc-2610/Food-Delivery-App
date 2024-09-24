
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RestaurantFoodDetailController extends GetxController {
  static RestaurantFoodDetailController get instance => Get.find();

  Rx<bool> isLoading = true.obs;
  String? dishId;
  Dish? dish;
  List<Order> orders = [];

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null) {
      dishId = Get.arguments["id"];
    }
    initialize();
  }

  Future<void> initialize() async {
    if(dishId != null) {
      dish = await APIService<Dish>().retrieve(dishId ?? '');
      orders = await APIService<Order>(fullUrl: dish?.inCartsOrOrders ?? '').list();
    }
    $print(dish);

    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();
  }
}