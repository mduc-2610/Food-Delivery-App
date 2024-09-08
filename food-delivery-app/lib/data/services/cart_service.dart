import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';

class CartService {
  static final CartService instance = CartService._();
  CartService._();

  Future<RestaurantCart?> fetchRestaurantCart(String? restaurantId) async {
    final user = await UserService.getUser(queryParams: "restaurant=$restaurantId");
    return user?.restaurantCart;
  }

  Future<RestaurantCart?> createRestaurantCart(String? restaurantId) async {
    final [statusCode, _, response] = await APIService<RestaurantCart>().create({
      'restaurant': restaurantId,
    });
    return response;
  }

  Future<RestaurantCartDish?> updateCartDish(String cartId, String dishId, int quantity) async {
    RestaurantCartDish cartDish = RestaurantCartDish(cart: cartId, dish: dishId, quantity: quantity);
    final [statusCode, _, response] = await APIService<RestaurantCartDish>().create(cartDish);
    return response;
  }

  Future<Order?> fetchOrder(String? cartId) async {
    return await APIService<Order>().retrieve(cartId ?? "");
  }
}
