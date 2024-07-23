// import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/user/food/views/category/food_category.dart';
import 'package:food_delivery_app/features/user/food/views/detail/food_detail.dart';
import 'package:food_delivery_app/features/user/food/views/more/food_more.dart';
import 'package:food_delivery_app/features/user/order/views/location/order_location.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  Rx<int> currentPageIndex = 0.obs;
  // final carouselController = carousel_slider.CarouselController();
  //
  // void updatePageIndicator(index) {
  //   currentPageIndex.value = index;
  // }
  //
  // void dotNavigationClick(index) {
  //   currentPageIndex.value = index;
  //   carouselController.jumpToPage(index);
  // }

  void getToFoodCategory(String category, {bool getOff = false}) {
    if (getOff) {
      Get.off(
            () => FoodCategoryView(),
        arguments: {"category": category},
      );
    } else {
      Get.to(
            () => FoodCategoryView(),
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