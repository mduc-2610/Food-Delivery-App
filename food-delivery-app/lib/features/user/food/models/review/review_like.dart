import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

abstract class ReviewLike {
  final String id;
  final String userId;
  final DateTime createdAt;

  ReviewLike({
    required this.id,
    required this.userId,
    required this.createdAt,
  });

  factory ReviewLike.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': userId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('ReviewLike', {
      'id': id,
      'userId': userId,
      'createdAt': createdAt,
    });
  }
}

class DishReviewLike extends ReviewLike {
  final String reviewId;

  DishReviewLike({
    required String id,
    required String userId,
    required this.reviewId,
    required DateTime createdAt,
  }) : super(id: id, userId: userId, createdAt: createdAt);

  factory DishReviewLike.fromJson(Map<String, dynamic> json) {
    return DishReviewLike(
      id: json['id'],
      userId: json['user'],
      reviewId: json['review'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      'review': reviewId,
    });
  }

  @override
  String toString() {
    return THelperFunction.formatToString('DishReviewLike', {
      'id': id,
      'userId': userId,
      'reviewId': reviewId,
      'createdAt': createdAt,
    });
  }
}

class RestaurantReviewLike extends ReviewLike {
  final String reviewId;

  RestaurantReviewLike({
    required String id,
    required String userId,
    required this.reviewId,
    required DateTime createdAt,
  }) : super(id: id, userId: userId, createdAt: createdAt);

  factory RestaurantReviewLike.fromJson(Map<String, dynamic> json) {
    return RestaurantReviewLike(
      id: json['id'],
      userId: json['user'],
      reviewId: json['review'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      'review': reviewId,
    });
  }

  @override
  String toString() {
    return THelperFunction.formatToString('RestaurantReviewLike', {
      'id': id,
      'userId': userId,
      'reviewId': reviewId,
      'createdAt': createdAt,
    });
  }
}

class DelivererReviewLike extends ReviewLike {
  final String reviewId;

  DelivererReviewLike({
    required String id,
    required String userId,
    required this.reviewId,
    required DateTime createdAt,
  }) : super(id: id, userId: userId, createdAt: createdAt);

  factory DelivererReviewLike.fromJson(Map<String, dynamic> json) {
    return DelivererReviewLike(
      id: json['id'],
      userId: json['user'],
      reviewId: json['review'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      'review': reviewId,
    });
  }

  @override
  String toString() {
    return THelperFunction.formatToString('DelivererReviewLike', {
      'id': id,
      'userId': userId,
      'reviewId': reviewId,
      'createdAt': createdAt,
    });
  }
}

class OrderReviewLike extends ReviewLike {
  final String reviewId;

  OrderReviewLike({
    required String id,
    required String userId,
    required this.reviewId,
    required DateTime createdAt,
  }) : super(id: id, userId: userId, createdAt: createdAt);

  factory OrderReviewLike.fromJson(Map<String, dynamic> json) {
    return OrderReviewLike(
      id: json['id'],
      userId: json['user'],
      reviewId: json['review'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      'review': reviewId,
    });
  }

  @override
  String toString() {
    return THelperFunction.formatToString('OrderReviewLike', {
      'id': id,
      'userId': userId,
      'reviewId': reviewId,
      'createdAt': createdAt,
    });
  }
}

