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
  final dynamic restaurant;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  bool isCreatedOrder;
  final bool isEmpty;
  final double totalPrice;
  final int totalItems;
  final List<RestaurantCartDish> cartDishes;
  final Order? order;

  RestaurantCart({
    this.id,
    this.user,
    this.restaurant,
    this.createdAt,
    this.updatedAt,
    this.isCreatedOrder = true,
    this.isEmpty = false,
    this.totalPrice = 0.0,
    this.totalItems = 0,
    this.cartDishes = const [],
    this.order,
  });

  RestaurantCart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'],
        restaurant = json['restaurant'] is String ? json['restaurant'] : json['restaurant'] != null ? Restaurant.fromJson(json['restaurant']) : null,
        createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
        updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
        isCreatedOrder = json['is_created_order'] ?? false,
        isEmpty = json['is_empty'] ?? false,
        totalPrice = THelperFunction.formatDouble(json['total_price']),
        totalItems = json['total_items'] ?? 0,
        cartDishes = json['dishes'] != null ? (json['dishes'] as List).map((instance) => RestaurantCartDish.fromJson(instance)).toList() : [],
        order = json['order'] != null ? Order.fromJson(json['order']) : null
  ;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'restaurant': restaurant,
      'is_created_order': isCreatedOrder,
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
  final dynamic cart;
  final dynamic dish;
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
        cart = json['cart'] != null ? json['cart'] is String || json['cart'] is List<dynamic> ? json['cart'] : RestaurantCart.fromJson(json['cart']) : null,
        dish = json['dish'] != null ? json['dish'] is String ? json['dish'] : Dish.fromJson(json['dish']) : null,
        quantity = json['quantity'] ?? 0,
        price = json['price'] != null ? double.parse(json['price']) : 0;

  Map<String, dynamic> toJson() {
    return {
      'cart': cart,
      'dish': (dish is String) ? dish : dish?.id,
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

