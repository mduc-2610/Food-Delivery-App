import 'dart:ffi';

import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class RestaurantCart {
  final String? id;
  final String? user;
  final Restaurant? restaurant;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isPlacedOrder;
  final double? rawFee;
  final List<RestaurantCartDish> cartDishes;
  final Order? order;

  RestaurantCart({
    this.id,
    this.user,
    this.restaurant,
    this.createdAt,
    this.updatedAt,
    this.isPlacedOrder,
    this.rawFee,
    this.cartDishes = const [],
    this.order,
  });

  RestaurantCart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'],
        restaurant = json['restaurant'] != null ? Restaurant.fromJson(json['restaurant']) : null,
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        isPlacedOrder = json['is_placed_order'],
        rawFee = json['raw_fee'] != null ? double.parse(json['raw_fee']) : null,
        cartDishes = json['dishes'] != null ? (json['dishes'] as List).map((instance) => RestaurantCartDish.fromJson(instance)).toList() : [],
        order = json['order'] != null ? Order.fromJson(json['order']) : null
  ;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'restaurant': restaurant,
      'is_placed_order': isPlacedOrder,
      'raw_fee': rawFee,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class RestaurantCartDish {
  final String? id;
  final String? cart;
  final Dish? dish;
  int quantity;
  final double price;

  RestaurantCartDish({
    this.id,
    this.cart,
    this.dish,
    this.quantity = 0,
    this.price = 0,
  });

  RestaurantCartDish.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cart = json['cart'],
        dish = json['dish'] != null ? Dish.fromJson(json['dish']) : null,
        quantity = json['quantity'] ?? 0,
        price = json['price'] != null ? double.parse(json['price']) : 0;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cart': cart,
      'dish': dish?.id,
      'quantity': quantity,
      'price': price,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

