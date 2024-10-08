import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

@reflector
class BaseReview {
  final String? id;
  final BasicUser? user;
  final int? rating;
  final String? title;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  late Rx<bool> isLiked;
  late Rx<int> totalLikes;

  BaseReview({
    this.id,
    this.user,
    this.rating,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
    int? totalLikes,
    bool? isLiked,
  }) {
    this.isLiked = (isLiked ?? false).obs;
    this.totalLikes = (totalLikes ?? 0).obs;
  }

  BaseReview.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = (json['user'] is String || json['user'] == null)
            ? null
            : BasicUser.fromJson(json['user']),
        rating = json['rating'],
        title = json['title'],
        content = json['content'],
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt = json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
        isLiked = Rx<bool>(json['is_liked'] ?? false),
        totalLikes = Rx<int>(json['total_likes'] ?? 0)
  ;

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
class DishReview extends BaseReview {
  final String? dish;

  DishReview({
    String? id,
    BasicUser? user,
    int? rating,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalLikes,
    bool? isLiked,
    this.dish,
  }) : super(
    id: id,
    user: user,
    rating: rating,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    totalLikes: totalLikes ?? 0,
    isLiked: isLiked ?? false,
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
class DelivererReview extends BaseReview {
  final String? deliverer;

  DelivererReview({
    String? id,
    BasicUser? user,
    int? rating,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalLikes,
    bool? isLiked,
    this.deliverer,
  }) : super(
    id: id,
    user: user,
    rating: rating,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    totalLikes: totalLikes ?? 0,
    isLiked: isLiked ?? false,
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
class RestaurantReview extends BaseReview {
  final String? restaurant;

  RestaurantReview({
    String? id,
    BasicUser? user,
    int? rating,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalLikes,
    bool? isLiked,
    this.restaurant,
  }) : super(
    id: id,
    user: user,
    rating: rating,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    totalLikes: totalLikes ?? 0,
    isLiked: isLiked ?? false,
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
class DeliveryReview extends BaseReview {
  final String? delivery;

  DeliveryReview({
    String? id,
    BasicUser? user,
    int? rating,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalLikes,
    bool? isLiked,
    this.delivery,
  }) : super(
    id: id,
    user: user,
    rating: rating,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    totalLikes: totalLikes ?? 0,
    isLiked: isLiked ?? false,
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
