import 'package:get/get.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';

class FoodListController extends GetxController {
  static FoodListController get instance => Get.find();

  final RestaurantDetailController restaurantDetailController = RestaurantDetailController.instance;
  User? user;

  @override
  void onInit() {
    super.onInit();
    user = restaurantDetailController.user;
  }

  void handleCartUpdate({required String dishId, required int quantity, void Function()? extra}) async {
    if (quantity == 0) return;

    if (user?.restaurantCart == null) {
      final [_, _, response] = await APIService<RestaurantCart>(fullUrl: user?.restaurantCarts ?? '').create({
        'restaurant': restaurantDetailController.restaurant?.id,
      }, noBearer: true);
      restaurantDetailController.user?.restaurantCart = response;
    }
    await restaurantDetailController.refreshCart();
    RestaurantCartDish cartDish = RestaurantCartDish(
      cart: restaurantDetailController.user?.restaurantCart?.id,
      dish: dishId,
      quantity: quantity,
    );
    final [statusCode, headers, response] = await APIService<RestaurantCartDish>().create(cartDish, noBearer: true);
    user?.restaurantCart = response.cart;
    restaurantDetailController.totalItems.value = user?.restaurantCart?.totalItems ?? 0;
    restaurantDetailController.totalPrice.value = user?.restaurantCart?.totalPrice ?? 0;
    restaurantDetailController.cartDishes.value = user?.restaurantCart?.cartDishes ?? [];
    if (quantity > 0) {
      restaurantDetailController.mapDishQuantity.update(dishId, (value) => value + quantity, ifAbsent: () => quantity);
    } else {
      if (restaurantDetailController.mapDishQuantity[dishId] != null && restaurantDetailController.mapDishQuantity[dishId]! + quantity > 0) {
        restaurantDetailController.mapDishQuantity.update(dishId, (value) => value + quantity);
      } else {
        restaurantDetailController.mapDishQuantity.remove(dishId);
      }
    }
    extra?.call();
    update();
  }
}