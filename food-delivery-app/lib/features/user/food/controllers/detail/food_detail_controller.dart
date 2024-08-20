import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/card/food_card_controller.dart';
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
  late final foodCardController;
  late final restaurantDetailController;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      dishId = Get.arguments['id'] ?? '';
      initializeDish(dishId!);
    }
    restaurantDetailController = RestaurantDetailController.instance;
  }

  Future<void> initializeDish(String id) async {
    dish = await APIService<Dish>().retrieve(id);
    foodCardController = Get.put(FoodCardController(dish), tag: dish?.id.toString());
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();
  }

  void handleRemoveFromCart() {
    foodCardController.handleRemoveFromCart(quantity: quantity.value);
  }

  void handleAddToCart() {
    foodCardController.handleAddToCart(quantity: quantity.value);
  }


  void getToFoodReview() {
    Get.to(() => DetailReviewView());
  }
}