import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
class Review {
  final String? id;
  final BasicUser? user;
  final int? rating;
  final String? title;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Review({
    this.id,
    this.user,
    this.rating,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  Review.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] is String || json['user'] == null ? json['user'] : BasicUser.fromJson(json['user']),
        rating = json['rating'],
        title = json['title'],
        content = json['content'],
        createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
        updatedAt = json['created_at'] != null ? DateTime.parse(json['updated_at']) : null;

  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = {
      'id': id,
      'user': user?.id,
      'rating': rating,
      'title': title,
      'content': content,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class DishReview extends Review {
  final String? dish;

  DishReview({
    String? id,
    BasicUser? user,
    int? rating,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.dish,
  }) : super(
    id: id,
    user: user,
    rating: rating,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  DishReview.fromJson(Map<String, dynamic> json)
      : dish = json['dish'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = super.toJson(patch: patch)..addAll({
      'dish': dish,
    });

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class DelivererReview extends Review {
  final String? deliverer;

  DelivererReview({
    String? id,
    BasicUser? user,
    int? rating,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.deliverer,
  }) : super(
    id: id,
    user: user,
    rating: rating,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  DelivererReview.fromJson(Map<String, dynamic> json)
      : deliverer = json['deliverer'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = super.toJson(patch: patch)..addAll({
      'deliverer': deliverer,
    });

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class RestaurantReview extends Review {
  final String? restaurant;

  RestaurantReview({
    String? id,
    BasicUser? user,
    int? rating,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.restaurant,
  }) : super(
    id: id,
    user: user,
    rating: rating,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  RestaurantReview.fromJson(Map<String, dynamic> json)
      : restaurant = json['restaurant'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = super.toJson(patch: patch)..addAll({
      'restaurant': restaurant,
    });

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class DeliveryReview extends Review {
  final String? delivery;

  DeliveryReview({
    String? id,
    BasicUser? user,
    int? rating,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.delivery,
  }) : super(
    id: id,
    user: user,
    rating: rating,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  DeliveryReview.fromJson(Map<String, dynamic> json)
      : delivery = json['order'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = super.toJson(patch: patch)..addAll({
      'order': delivery,
    });

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
