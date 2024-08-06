import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/user/food/models/food/category.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/views/detail/food_detail.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:get/get.dart';

class RestaurantDetailController extends GetxController with SingleGetTickerProviderMixin {
  static RestaurantDetailController get instance => Get.find();

  String? restaurantId;
  Restaurant? restaurant;
  List<DishCategory> categories = [];
  List<Dish> dishes = [];
  Map<String, List<Dish>> mapCategory = {};
  Rx<bool> isLoading = true.obs;
  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      restaurantId = Get.arguments['id'];
      initializeRestaurant(restaurantId ?? "");
    }
  }

  Future<void> initializeRestaurant(String id) async {
    restaurant = await APIService<Restaurant>().retrieve(id);
    categories = restaurant?.categories ?? [];
    await loadDishes();
    await Future.delayed(Duration(milliseconds: TTime.init));
    tabController = TabController(length: categories.length, vsync: this);
    isLoading.value = false;
    update();
  }

  Future<void> loadDishes() async {
    for (var category in categories) {
      mapCategory[category.name ?? ""] = await APIService<Dish>(
        fullUrl: restaurant?.dishes ?? "",
        queryParams: 'category=${category.id}',
      ).list();
      if (mapCategory[category.name ?? ""]!.isNotEmpty) {
        dishes = mapCategory[category.name ?? ""]!;
      }
    }
  }

  void getToFoodDetail() {
    Get.to(() => FoodDetailView());
  }
}
