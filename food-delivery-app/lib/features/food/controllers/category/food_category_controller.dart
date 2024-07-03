import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/food/views/detail/food_detail.dart';
import 'package:get/get.dart';

class FoodCategoryController extends GetxController {
  static FoodCategoryController get instance => Get.find();

  var category = "".obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      category.value = Get.arguments['category'] ?? '';
    }
  }

  void getToFoodDetail() {
    Get.to(() => FoodDetailView());
  }
}