import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/user/food/models/food/category.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/views/detail/food_detail.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RestaurantDetailController extends GetxController with SingleGetTickerProviderMixin {
  static RestaurantDetailController get instance => Get.find();

  User? user;
  String? restaurantId;
  Restaurant? restaurant;
  List<DishCategory> categories = [];
  List<Dish> dishes = [];
  Map<String, List<Dish>> mapCategory = {};
  Rx<bool> isLoading = true.obs;
  TabController? tabController;
  RestaurantCart? restaurantCart;
  var mapDishQuantity = {}.obs;
  var totalItems = 0.obs;
  var cartDishes = [].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      restaurantId = Get.arguments['id'];
      initializeRestaurant();
    }
  }

  Future<void> initializeRestaurant() async {
    user = await UserService.getUser(queryParams: "restaurant=${restaurantId}");
    restaurant = await APIService<Restaurant>().retrieve(restaurantId ?? "");
    categories = restaurant?.categories ?? [];
    await loadDishes();
    await Future.delayed(Duration(milliseconds: TTime.init));
    tabController = TabController(length: categories.length, vsync: this);
    restaurantCart = user?.restaurantCart;
    for(var item in restaurantCart?.cartDishes ?? []) {
      mapDishQuantity[item.dish.id] = item.quantity;
      totalItems.value += item.quantity as int;
    }
    isLoading.value = false;
    update();
  }

  Future<void> loadDishes() async {
    for (var category in categories) {
      mapCategory[category.name ?? ""] = await APIService<Dish>(
        fullUrl: restaurant?.dishes ?? "",
        queryParams: 'category=${category.id}',
      ).list(pagination: false);
      if (mapCategory[category.name ?? ""]!.isNotEmpty) {
        dishes = mapCategory[category.name ?? ""]!;
      }
    }
  }

  void getToFoodDetail() {
    Get.to(() => FoodDetailView());
  }
}
