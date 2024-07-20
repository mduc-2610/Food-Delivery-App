import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Cart {
  final String? userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Cart({
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  Cart.fromJson(Map<String, dynamic> json)
      : userId = json['user'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() {
    return {
      'user': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Cart', {
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    });
  }
}

class RestaurantCart {
  final String id;
  final String cartId;
  final String restaurantId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPlacedOrder;
  final double rawFee;

  RestaurantCart({
    required this.id,
    required this.cartId,
    required this.restaurantId,
    required this.createdAt,
    required this.updatedAt,
    required this.isPlacedOrder,
    required this.rawFee,
  });

  RestaurantCart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cartId = json['cart'],
        restaurantId = json['restaurant'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        isPlacedOrder = json['is_placed_order'],
        rawFee = json['raw_fee'].toDouble();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cart': cartId,
      'restaurant': restaurantId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_placed_order': isPlacedOrder,
      'raw_fee': rawFee,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('RestaurantCart', {
      'id': id,
      'cartId': cartId,
      'restaurantId': restaurantId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isPlacedOrder': isPlacedOrder,
      'rawFee': rawFee,
    });
  }
}

class RestaurantCartDish {
  final String id;
  final String cartId;
  final String dishId;
  final int quantity;
  final double price;

  RestaurantCartDish({
    required this.id,
    required this.cartId,
    required this.dishId,
    required this.quantity,
    required this.price,
  });

  RestaurantCartDish.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cartId = json['cart'],
        dishId = json['dish'],
        quantity = json['quantity'],
        price = json['price'].toDouble();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cart': cartId,
      'dish': dishId,
      'quantity': quantity,
      'price': price,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('RestaurantCartDish', {
      'id': id,
      'cartId': cartId,
      'dishId': dishId,
      'quantity': quantity,
      'price': price,
    });
  }
}

