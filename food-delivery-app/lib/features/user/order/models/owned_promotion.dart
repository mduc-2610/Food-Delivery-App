import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';


class OwnedPromotion {
  final String id;
  final String promotionId;
  final DateTime timestamp;

  OwnedPromotion({
    required this.id,
    required this.promotionId,
    required this.timestamp,
  });

  OwnedPromotion.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        promotionId = json['promotion'],
        timestamp = DateTime.parse(json['timestamp']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'promotion': promotionId,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class OrderPromotion extends OwnedPromotion {
  final String orderId;

  OrderPromotion({
    required String id,
    required String promotionId,
    required DateTime timestamp,
    required this.orderId,
  }) : super(id: id, promotionId: promotionId, timestamp: timestamp);

  OrderPromotion.fromJson(Map<String, dynamic> json)
      : orderId = json['order'],
        super.fromJson(json);

  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'order': orderId,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class RestaurantPromotion extends OwnedPromotion {
  final String restaurantId;

  RestaurantPromotion({
    required String id,
    required String promotionId,
    required DateTime timestamp,
    required this.restaurantId,
  }) : super(id: id, promotionId: promotionId, timestamp: timestamp);

  RestaurantPromotion.fromJson(Map<String, dynamic> json)
      : restaurantId = json['restaurant'],
        super.fromJson(json);

  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'restaurant': restaurantId,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class UserPromotion extends OwnedPromotion {
  final String userId;

  UserPromotion({
    required String id,
    required String promotionId,
    required DateTime timestamp,
    required this.userId,
  }) : super(id: id, promotionId: promotionId, timestamp: timestamp);

  UserPromotion.fromJson(Map<String, dynamic> json)
      : userId = json['user'],
        super.fromJson(json);

  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'user': userId,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
