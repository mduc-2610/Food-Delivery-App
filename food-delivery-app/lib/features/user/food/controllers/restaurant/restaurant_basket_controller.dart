import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RestaurantBasketController extends GetxController {
  static RestaurantBasketController get instance => Get.find();
  User? user;
  var isLoading = true.obs;
  final restaurantDetailController = RestaurantDetailController.instance;
  var cartDishes = [].obs;

  @override
  void onInit() {
    super.onInit();
    initializeRestaurant();
  }

  Future<void> initializeRestaurant() async {
    user = await UserService.getUser(queryParams: "restaurant=${restaurantDetailController.restaurantId}");
    await Future.delayed(Duration(milliseconds:  (TTime.init / 2).toInt()));
    isLoading.value = false;
    cartDishes.value = user?.restaurantCart?.cartDishes ?? [];
    update();
  }

  Future<void> addToCart() async {
    await initializeRestaurant();
  }

  Future<void> removeFromCart() async {
    await initializeRestaurant();
    if(restaurantDetailController.totalItems.value == 0)
    Get.back();
  }

}