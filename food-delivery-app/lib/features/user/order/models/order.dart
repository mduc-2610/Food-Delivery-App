import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class Order {
  final String? id;
  final dynamic cart;
  final dynamic deliveryAddress;
  final dynamic cancellation;
  final String? paymentMethod;
  final String? promotion;
  final double deliveryFee;
  final double discount;
  double total;
  double totalPrice;
  final int rating;
  final String? status;

  Order({
    this.id,
    this.cart,
    this.deliveryAddress,
    this.paymentMethod,
    this.cancellation,
    this.promotion,
    this.deliveryFee = 0,
    this.discount = 0,
    this.total = 0,
    this.rating = 0,
    this.totalPrice = 0,
    this.status,
  });

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cart = json['cart'] == null || json['cart'] is String || json['cart'] is List ? json['cart'] : RestaurantCart.fromJson(json['cart']),
        deliveryAddress = json['delivery_address'] == null || json['delivery_address'] is String ? json['delivery_address'] : UserLocation.fromJson(json['delivery_address']),
        cancellation = json['cancellation'] == null || json['cancellation'] is String ? json['cancellation'] : OrderCancellation.fromJson(json['cancellation']),
        paymentMethod = json['payment_method'],
        promotion = json['promotion'],
        deliveryFee = THelperFunction.formatDouble(json['delivery_fee']),
        discount = THelperFunction.formatDouble(json['discount']),
        totalPrice = THelperFunction.formatDouble(json['total_price']),
        total = THelperFunction.formatDouble(json['total']),
        rating = json['rating'] ?? 0,
        status = json['status'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cart': cart is String ? cart : cart?.toJson(),
      'delivery_address': deliveryAddress,
      'payment_method': paymentMethod,
      'promotion': promotion,
      'delivery_fee': deliveryFee,
      'discount': discount,
      'total': total,
      'status': status,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class OrderCancellation {
  final dynamic order;
  final dynamic user;
  final dynamic restaurant;
  final String? reason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isAccepted;

  OrderCancellation({
    this.order,
    this.user,
    this.restaurant,
    this.reason,
    this.createdAt,
    this.updatedAt,
    this.isAccepted = false,
  });

  OrderCancellation.fromJson(Map<String, dynamic> json)
    : order = json['order'] == null || json['order'] is String || json['order'] is List ? json['order']  : Order.fromJson(json['order']),
      user = json['user'] == null || json['user'] is String || json['user'] is List ? json['user']  : User.fromJson(json['user']),
      restaurant = json['restaurant'] == null || json['restaurant'] is String || json['restaurant'] is List? json['restaurant'] : Restaurant.fromJson(json['restaurant']),
      reason = json['reason'],
      createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      isAccepted = json['is_accepted'] ?? false
  ;

  Map<String, dynamic> toJson() {
    return {
      'order': order is String ? order : order?.id,
      'user': user is String ? user : user?.id,
      'restaurant': restaurant is String ? restaurant : restaurant?.id,
      'reason': reason,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}