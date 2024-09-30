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
  var mapDishQuantity = {}.obs;
  var totalItems = 0.obs;
  var totalPrice = 0.0.obs;
  var cartDishes = [].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      restaurantId = Get.arguments['id'];
      initializeRestaurant();
    }
  }

  Future<void> refreshCart() async {
    user = await UserService.getUser(queryParams: "restaurant=${restaurantId}");
  }

  Future<void> initializeRestaurant() async {
    user = await UserService.getUser(queryParams: "restaurant=${restaurantId}");
    restaurant = await APIService<Restaurant>().retrieve(restaurantId ?? "");
    isLiked.value = restaurant?.isLiked ?? false;
    categories = restaurant?.categories ?? [];
    await loadDishes();
    await Future.delayed(Duration(milliseconds: TTime.init));
    tabController = TabController(length: categories.length, vsync: this);
    for (var item in user?.restaurantCart?.cartDishes ?? []) {
      mapDishQuantity[item.dish.id] = item.quantity;
    }
    totalItems.value = user?.restaurantCart?.totalItems ?? 0;
    totalPrice.value = user?.restaurantCart?.totalPrice ?? 0;
    cartDishes.addAll(user?.restaurantCart?.cartDishes ?? []);
    $print(cartDishes.length);
    $print(user?.restaurantCart?.cartDishes);
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
  Rx<bool> isLiked = false.obs;
  Future<void> toggleLike() async {
    if (isLiked.value) {
      await unlikeRestaurant();
    } else {
      await likeRestaurant();
    }
    update();
  }

  Future<void> likeRestaurant() async {
    try {
      final currentUser = user;
      if (currentUser == null || currentUser.id == null) {
        Get.snackbar('Error', 'User not found.');
        return;
      }

      final like = RestaurantLike(
        restaurant: restaurantId,
        user: currentUser.id,
      );
      $print(like);
      final createdLike = await APIService<RestaurantLike>().create(like.toJson());

      if (createdLike != null) {
        isLiked.value = true;
        restaurant?.totalLikes += 1;
        // Get.snackbar('Success', 'You have liked this restaurant.');
      } else {
        // Get.snackbar('Error', 'Failed to like the restaurant.');
      }
    } catch (e) {
      // Get.snackbar('Error', 'An error occurred while liking the restaurant.');
    }
  }

  Future<void> unlikeRestaurant() async {
    try {
      final currentUser = user;
      if (currentUser == null || currentUser.id == null) {
        // Get.snackbar('Error', 'User not found.');
        return;
      }

      final likes = await APIService<RestaurantLike>(queryParams: 'user=${currentUser.id}&restaurant=${restaurantId}').list();

      if (likes.isNotEmpty) {
        final like = likes.first;

        final success = await APIService<RestaurantLike>().delete(like.id!);
        if (success) {
          isLiked.value = false;
          restaurant?.totalLikes -= 1;
          // Get.snackbar('Success', 'You have unliked this restaurant.');
        } else {
          // Get.snackbar('Error', 'Failed to unlike the restaurant.');
        }
      } else {
        // Get.snackbar('Error', 'Like entry not found.');
      }
    } catch (e) {
      // Get.snackbar('Error', 'An error occurred while unliking the restaurant.');
    }
  }
}

