import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/list/food_list_controller.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/views/review/detail_review.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class FoodDetailController extends GetxController {
  static FoodDetailController get instance => Get.find();

  Dish? dish;
  String? dishId;
  Rx<bool> isLoading = true.obs;
  var quantity = 1.obs;
  late final foodListController = FoodListController.instance;
  late final restaurantDetailController = RestaurantDetailController.instance;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      dishId = Get.arguments['id'] ?? '';
      initializeDish(dishId!);
    }
  }

  Future<void> initializeDish(String id) async {
    dish = await APIService<Dish>().retrieve(id);
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();
  }

  void handleRemoveFromCart() {
    foodListController.handleCartUpdate(dishId: dishId ?? '', quantity: -1);
  }

  void handleAddToCart() {
    foodListController.handleCartUpdate(dishId: dishId ?? '', quantity: 1);
  }


  void getToFoodReview() {
    Get.to(() => DetailReviewView(item: dish,));
  }
}