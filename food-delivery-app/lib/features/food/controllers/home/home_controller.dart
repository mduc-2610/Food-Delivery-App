import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/food/views/category/food_category.dart';
import 'package:food_delivery_app/features/food/views/detail/food_detail.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  Rx<int> currentPageIndex = 0.obs;
  final carouselController = CarouselController();

  void updatePageIndicator(index) {
    currentPageIndex.value = index;
  }

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    carouselController.jumpToPage(index);
  }

  void getToFoodCategory(String category) {
    Get.to(
      () => FoodCategoryView(),
      arguments: {
        "category": category
      }
    );
  }

  void getToFoodDetail(String id) {
    Get.to(
      () => FoodDetailView(),
      arguments: {
        "id": id
      }
    );
  }
}