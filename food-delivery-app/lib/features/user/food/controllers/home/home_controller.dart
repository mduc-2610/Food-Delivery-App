import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/user/food/views/detail/food_detail.dart';
import 'package:food_delivery_app/features/user/food/views/more/food_more.dart';
import 'package:food_delivery_app/features/user/food/views/restaurant/restaurant_category.dart';
import 'package:food_delivery_app/features/user/order/views/location/order_location.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  void getToFoodCategory(String category, {bool getOff = false}) {
    if (getOff) {
      Get.off(
            () => RestaurantCategoryView(),
        arguments: {"category": category},
      );
    } else {
      Get.to(
            () => RestaurantCategoryView(),
        arguments: {"category": category},
      );
    }
  }

  void getToOrderLocation() {
    Get.to(() => OrderLocationSelectView());
  }


  void getToFoodDetail(String id) {
    Get.to(
      () => FoodDetailView(),
      arguments: {
        "id": id
      }
    );
  }

  void getToFoodMore() {
    Get.to(() => FoodMoreView());
  }
}