import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';

class FoodListController extends GetxController {
  static FoodListController get instance => Get.find();

  final RestaurantDetailController restaurantDetailController = RestaurantDetailController.instance;

  @override
  void onInit() {
    super.onInit();
  }

  void handleCartUpdate({required String dishId, required int quantity, void Function()? extra}) async {
    $print(restaurantDetailController.user?.restaurantCart?.id);
    if (quantity == 0) return;

    if (restaurantDetailController.user?.restaurantCart == null) {
      final [_, _, response] = await APIService<RestaurantCart>(fullUrl: restaurantDetailController.user?.restaurantCarts ?? '').create({
        'restaurant': restaurantDetailController.restaurant?.id,
      }, noBearer: true);
      restaurantDetailController.user?.restaurantCart = response;
      $print("NO");
    }
    RestaurantCartDish cartDish = RestaurantCartDish(
      cart: restaurantDetailController.user?.restaurantCart?.id,
      dish: dishId,
      quantity: quantity,
    );
    $print(cartDish.toJson());
    final [statusCode, headers, response] = await APIService<RestaurantCartDish>().create(cartDish, noBearer: true);
    restaurantDetailController.user?.restaurantCart = response.cart;
    restaurantDetailController.totalItems.value = restaurantDetailController.user?.restaurantCart?.totalItems ?? 0;
    restaurantDetailController.totalPrice.value = restaurantDetailController.user?.restaurantCart?.totalPrice ?? 0;
    restaurantDetailController.cartDishes.value = restaurantDetailController.user?.restaurantCart?.cartDishes ?? [];
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