import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class Order {
  final String id;
  final String cartId;
  final String deliveryAddress;
  final String paymentMethod;
  final String? promotionId;
  final double deliveryFee;
  final double discount;
  final double total;
  final String status;

  Order({
    required this.id,
    required this.cartId,
    required this.deliveryAddress,
    required this.paymentMethod,
    this.promotionId,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    required this.status,
  });

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cartId = json['cart'],
        deliveryAddress = json['delivery_address'],
        paymentMethod = json['payment_method'],
        promotionId = json['promotion'],
        deliveryFee = json['delivery_fee'].toDouble(),
        discount = json['discount'].toDouble(),
        total = json['total'].toDouble(),
        status = json['status'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cart': cartId,
      'delivery_address': deliveryAddress,
      'payment_method': paymentMethod,
      'promotion': promotionId,
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
