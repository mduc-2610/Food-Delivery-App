import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/views/detail/food_detail_review.dart';
import 'package:get/get.dart';

class FoodDetailController extends GetxController {
  static FoodDetailController get instance => Get.find();

  Dish? dish;
  String? dishId;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      dishId = Get.arguments['id'];
      initializeDish(dishId!);
    }
  }

  Future<void> initializeDish(String id) async {
    dish = await APIService<Dish>().retrieve(id);
  }

  void getToFoodReview() {
    Get.to(() => FoodDetailReviewView());
  }
}