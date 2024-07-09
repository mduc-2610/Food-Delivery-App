import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/user/food/views/detail/food_detail_review.dart';
import 'package:get/get.dart';

class FoodDetailController extends GetxController {
  static FoodDetailController get instance => Get.find();

  void getToFoodReview() {
    Get.to(() => FoodDetailReviewView());
  }
}