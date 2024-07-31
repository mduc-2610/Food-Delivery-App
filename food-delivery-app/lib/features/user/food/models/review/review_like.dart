import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
class ReviewLike {
  final String? id;
  final dynamic user;
  final String? review;
  final DateTime? createdAt;

  ReviewLike({
    this.id,
    this.user,
    this.review,
    this.createdAt,
  });

  ReviewLike.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      user = UserAbbr.fromJson(json['user']),
      review = json['review'],
      createdAt = DateTime.parse(json['created_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'review': review,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@jsonSerializable
class DishReviewLike extends ReviewLike {

  DishReviewLike({
    String? id,
    UserAbbr? user,
    String? review,
    DateTime? createdAt,
  }) : super(id: id, user: user, createdAt: createdAt);

  DishReviewLike.fromJson(Map<String, dynamic> json)
    : super.fromJson(json);
}

@jsonSerializable
class RestaurantReviewLike extends ReviewLike {

  RestaurantReviewLike({
    String? id,
    UserAbbr? user,
    String? review,
    DateTime? createdAt,
  }) : super(id: id, user: user, createdAt: createdAt);

  RestaurantReviewLike.fromJson(Map<String, dynamic> json)
    : super.fromJson(json);
}

@jsonSerializable
class DelivererReviewLike extends ReviewLike {
  DelivererReviewLike({
    String? id,
    UserAbbr? user,
    String? review,
    DateTime? createdAt,
  }) : super(id: id, user: user, createdAt: createdAt);

  DelivererReviewLike.fromJson(Map<String, dynamic> json)
    : super.fromJson(json);
}

@jsonSerializable
class DeliveryReviewLike extends ReviewLike {
  DeliveryReviewLike({
    String? id,
    UserAbbr? user,
    String? review,
    DateTime? createdAt,
  }) : super(id: id, user: user, createdAt: createdAt);

  DeliveryReviewLike.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);
}

