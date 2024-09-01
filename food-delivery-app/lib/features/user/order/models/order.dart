import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class Order {
  final String? id;
  final dynamic cart;
  final dynamic deliveryAddress;
  final String? paymentMethod;
  final String? promotion;
  final double deliveryFee;
  final double discount;
  double total;
  final int rating;
  final String? status;

  Order({
    this.id,
    this.cart,
    this.deliveryAddress,
    this.paymentMethod,
    this.promotion,
    this.deliveryFee = 0,
    this.discount = 0,
    this.total = 0,
    this.rating = 0,
    this.status,
  });

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cart = json['cart'] == null || json['cart'] is String || json['cart'] is List ? json['cart'] : RestaurantCart.fromJson(json['cart']),
        deliveryAddress = json['delivery_address'] == null || json['delivery_address'] is String ? json['delivery_address'] : UserLocation.fromJson(json['delivery_address']),
        paymentMethod = json['payment_method'],
        promotion = json['promotion'],
        deliveryFee = THelperFunction.formatDouble(json['delivery_fee']),
        discount = THelperFunction.formatDouble(json['discount']),
        total = THelperFunction.formatDouble(json['total']),
        rating = json['rating'] ?? 0,
        status = json['status'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cart': cart,
      'delivery_address': deliveryAddress?.id,
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
