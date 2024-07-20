import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

abstract class Review {
  final String id;
  final String userId;
  final int rating;
  final String? title;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  Review({
    required this.id,
    required this.userId,
    required this.rating,
    this.title,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': userId,
      'rating': rating,
      'title': title,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Review', {
      'id': id,
      'userId': userId,
      'rating': rating,
      'title': title,
      'comment': comment,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    });
  }
}

class DishReview extends Review {
  final String dishId;

  DishReview({
    required String id,
    required String userId,
    required int rating,
    String? title,
    required String comment,
    required DateTime createdAt,
    required DateTime updatedAt,
    required this.dishId,
  }) : super(
    id: id,
    userId: userId,
    rating: rating,
    title: title,
    comment: comment,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  factory DishReview.fromJson(Map<String, dynamic> json) {
    return DishReview(
      id: json['id'],
      userId: json['user'],
      rating: json['rating'],
      title: json['title'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      dishId: json['dish'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      'dish': dishId,
    });
  }

  @override
  String toString() {
    return THelperFunction.formatToString('DishReview', {
      'id': id,
      'userId': userId,
      'rating': rating,
      'title': title,
      'comment': comment,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'dishId': dishId,
    });
  }
}

class DelivererReview extends Review {
  final String delivererId;

  DelivererReview({
    required String id,
    required String userId,
    required int rating,
    String? title,
    required String comment,
    required DateTime createdAt,
    required DateTime updatedAt,
    required this.delivererId,
  }) : super(
    id: id,
    userId: userId,
    rating: rating,
    title: title,
    comment: comment,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  factory DelivererReview.fromJson(Map<String, dynamic> json) {
    return DelivererReview(
      id: json['id'],
      userId: json['user'],
      rating: json['rating'],
      title: json['title'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      delivererId: json['deliverer'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      'deliverer': delivererId,
    });
  }

  @override
  String toString() {
    return THelperFunction.formatToString('DelivererReview', {
      'id': id,
      'userId': userId,
      'rating': rating,
      'title': title,
      'comment': comment,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'delivererId': delivererId,
    });
  }
}

class RestaurantReview extends Review {
  final String restaurantId;

  RestaurantReview({
    required String id,
    required String userId,
    required int rating,
    String? title,
    required String comment,
    required DateTime createdAt,
    required DateTime updatedAt,
    required this.restaurantId,
  }) : super(
    id: id,
    userId: userId,
    rating: rating,
    title: title,
    comment: comment,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  factory RestaurantReview.fromJson(Map<String, dynamic> json) {
    return RestaurantReview(
      id: json['id'],
      userId: json['user'],
      rating: json['rating'],
      title: json['title'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      restaurantId: json['restaurant'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      'restaurant': restaurantId,
    });
  }

  @override
  String toString() {
    return THelperFunction.formatToString('RestaurantReview', {
      'id': id,
      'userId': userId,
      'rating': rating,
      'title': title,
      'comment': comment,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'restaurantId': restaurantId,
    });
  }
}

class OrderReview extends Review {
  final String orderId;

  OrderReview({
    required String id,
    required String userId,
    required int rating,
    String? title,
    required String comment,
    required DateTime createdAt,
    required DateTime updatedAt,
    required this.orderId,
  }) : super(
    id: id,
    userId: userId,
    rating: rating,
    title: title,
    comment: comment,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  factory OrderReview.fromJson(Map<String, dynamic> json) {
    return OrderReview(
      id: json['id'],
      userId: json['user'],
      rating: json['rating'],
      title: json['title'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      orderId: json['order'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({
      'order': orderId,
    });
  }

  @override
  String toString() {
    return THelperFunction.formatToString('OrderReview', {
      'id': id,
      'userId': userId,
      'rating': rating,
      'title': title,
      'comment': comment,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'orderId': orderId,
    });
  }
}