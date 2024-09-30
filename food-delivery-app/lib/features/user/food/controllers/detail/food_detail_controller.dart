import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/list/food_list_controller.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish_like.dart';
import 'package:food_delivery_app/features/user/food/views/review/detail_review.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class FoodDetailController extends GetxController {
  static FoodDetailController get instance => Get.find();

  String? dishId;
  User? user;
  Dish? dish;

  Rx<bool> isLoading = true.obs;
  Rx<bool> isLiked = false.obs;
  Rx<int> quantity = 1.obs;

  late final foodListController = FoodListController.instance;
  late final restaurantDetailController = RestaurantDetailController.instance;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      dishId = Get.arguments['id'] ?? '';
      initializeDish(dishId!);
    }
  }

  Future<void> initializeDish(String id) async {
    user = await UserService.getUser();
    dish = await APIService<Dish>().retrieve(id);
    isLiked.value = dish?.isLiked ?? false;
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();
  }

  void handleRemoveFromCart() {
    foodListController.handleCartUpdate(dishId: dishId ?? '', quantity: -1);
  }

  void handleAddToCart() {
    foodListController.handleCartUpdate(dishId: dishId ?? '', quantity: 1);
  }


  void getToFoodReview() {
    Get.to(() => DetailReviewView(item: dish,));
  }

  /// Toggle like status of the dish
  Future<void> toggleLike() async {
    if (isLiked.value) {
      await unlikeDish();
    } else {
      await likeDish();
    }
    update();
  }

  Future<void> likeDish() async {
    try {
      final currentUser = user;
      if (currentUser == null || currentUser.id == null) {
        // Get.snackbar('Error', 'User not found.');
        return;
      }

      final like = DishLike(
        dish: dishId,
        user: currentUser.id,
      );
      $print(like);

      final createdLike = await APIService<DishLike>().create(like.toJson());
      $print(createdLike);
      if (createdLike != null) {
        isLiked.value = true;
        dish?.totalLikes += 1;
        // Get.snackbar('Success', 'You have liked this dish.');
      } else {
        // Get.snackbar('Error', 'Failed to like the dish.');
      }
    } catch (e) {
      // Get.snackbar('Error', 'An error occurred while liking the dish.');
    }
  }

  Future<void> unlikeDish() async {
    try {
      final currentUser = user;
      if (currentUser == null || currentUser.id == null) {
        // Get.snackbar('Error', 'User not found.');
        return;
      }

      final likes = await APIService<DishLike>(queryParams: 'user=${currentUser.id}&dish=${dishId}',).list();
      if (likes.isNotEmpty) {
        final like = likes.first;
        $print("LIKE $like");
        final success = await APIService<DishLike>().delete(like.id!);
        $print(success);
        if (success) {
          isLiked.value = false;
          dish?.totalLikes -= 1;
          // Get.snackbar('Success', 'You have unliked this dish.');
        } else {
          // Get.snackbar('Error', 'Failed to unlike the dish.');
        }
      } else {
        // Get.snackbar('Error', 'Like entry not found.');
      }
    } catch (e) {
      // Get.snackbar('Error', 'An error occurred while unliking the dish.');
    }
  }
}