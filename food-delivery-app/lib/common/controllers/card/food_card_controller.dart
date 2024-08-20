import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/views/splash/splash.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_basket_controller.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/views/restaurant/widgets/restaurant_dish_option.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class FoodCardController extends GetxController {
  static FoodCardController get instance => Get.find();

  User? user;
  final Dish? dish;
  final RestaurantDetailController restaurantDetailController = RestaurantDetailController.instance;
  FoodCardController(this.dish);

  @override
  void onInit() {
    super.onInit();
    user = restaurantDetailController.user;
  }

  void handleAddToCart({ int? quantity, void Function()? extra }) async {
    $print(dish?.id);
    // showModalBottomSheet(context: Get.context!, isScrollControlled: true,isDismissible: false, builder: (context) {
    //   return RestaurantDishOption(dish: dish,);
    // });
    if(true || dish?.options == null || dish?.options == []) {
      if (restaurantDetailController.restaurantCart == null && user?.restaurantCarts != null) {
        final [_, _, response] = await APIService<RestaurantCart>(fullUrl: user?.restaurantCarts ?? '').create({
          'restaurant': restaurantDetailController.restaurant?.id,
        }, noBearer: true, fromJson: RestaurantCart.fromJson);
        restaurantDetailController.restaurantCart = response;
      }

      final [statusCode, headers, response] = await APIService<RestaurantCartDish>().create(RestaurantCartDish(
        cart: restaurantDetailController.restaurantCart?.id,
        dish: dish?.id,
        quantity: quantity ?? 1,
      ), noBearer: true);
      $print([statusCode, headers, response]);
      restaurantDetailController.totalItems.value += quantity ?? 1;
      restaurantDetailController.mapDishQuantity.update(dish?.id ?? '', (value) => value + (quantity ?? 1), ifAbsent: () => 1);
    }
    extra?.call();
    update();
  }

  void handleRemoveFromCart({ int? quantity, void Function()? extra }) async {
    if(quantity != null && quantity > 0) quantity *= -1;
    final [statusCode, headers, response] = await APIService<
        RestaurantCartDish>().create(RestaurantCartDish(
      cart: restaurantDetailController.restaurantCart?.id,
      dish: dish?.id,
      quantity: quantity ?? -1,
    ), noBearer: true);
    $print("${dish?.id} : ${restaurantDetailController.mapDishQuantity[dish?.id]}");

    restaurantDetailController.totalItems.value += quantity ?? -1;
    if (restaurantDetailController.mapDishQuantity[dish?.id] != null && restaurantDetailController.mapDishQuantity[dish?.id] > 1) {
      restaurantDetailController.mapDishQuantity.update(
          dish?.id ?? '', (value) => value + (quantity ?? -1), ifAbsent: () => 1);
    }
    else {
      restaurantDetailController.mapDishQuantity.remove(dish?.id);
      extra?.call();
    }
  }

  void handleLike() {

  }
}