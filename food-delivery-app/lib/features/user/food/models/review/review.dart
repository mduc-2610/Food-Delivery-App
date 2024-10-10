import 'package:dio/dio.dart' as dio;
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/food/models/review/review_image.dart';
import 'package:food_delivery_app/features/user/food/models/review/review_reply.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

@reflector
class BaseReview {
  final String? id;
  final dynamic user;
  final String? order;
  final int? rating;
  final String? title;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  List<dynamic> images;
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
    this.order,
    this.images = const [],
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
        order = json['order'],
        rating = json['rating'],
        title = json['title'],
        content = json['content'],
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt = json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
        images = (json['images'] as List<dynamic>?)
            ?.map((image) => ReviewImage.fromJson(image))
            .toList() ??
            [],
        isLiked = Rx<bool>(json['is_liked'] ?? false),
        totalLikes = Rx<int>(json['total_likes'] ?? 0);

  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = {
      'id': id,
      'user': user is String ? user : user?.id,
      'rating': rating,
      'title': title,
      'content': content,
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  Future<List<dynamic>> get multiPartImages async {
    bool getStrUrl = true;
    return await THelperFunction.convertListToMultipartFile(images, getStrUrl: getStrUrl);
  }

  Future<dio.FormData> toFormData({bool patch = false}) async {
    var [_multiPartImages, _imageUrls] = await multiPartImages;
    Map<String, dynamic> data = {
      'id': id,
      'user': user is String ? user : user?.id,
      'rating': rating,
      'title': title,
      'content': content,
      'image_urls': _imageUrls
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    dio.FormData formData = dio.FormData.fromMap(data);

    for (var image in _multiPartImages) {
      formData.files.add(MapEntry('images', image));
    }

    return formData;
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
  late RxList<DishReviewReply> replies;

  DishReview({
    String? id,
    dynamic user,
    String? order,
    int? rating,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalLikes,
    bool? isLiked,
    List<dynamic>? images,
    this.dish,
    List<DishReviewReply>? replies,
  })  : replies = (replies ?? []).obs,
        super(
        id: id,
        user: user,
        order: order,
        rating: rating,
        title: title,
        content: content,
        createdAt: createdAt,
        updatedAt: updatedAt,
        totalLikes: totalLikes ?? 0,
        isLiked: isLiked ?? false,
        images: images ?? [],
      );

  DishReview.fromJson(Map<String, dynamic> json)
      : dish = json['dish'],
        replies = (json['replies'] as List<dynamic>?)
            ?.map((reply) => DishReviewReply.fromJson(reply))
            .toList()
            ?.obs ??
            <DishReviewReply>[].obs,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = super.toJson(patch: patch)..addAll({
      'dish': dish,
      'replies': replies.map((reply) => reply.toJson()).toList(),
    });

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  Future<dio.FormData> toFormData({bool patch = false}) async {
    dio.FormData formData = await super.toFormData(patch: patch);

    if (dish != null) {
      formData.fields.add(MapEntry('dish', dish!));
    }


    return formData;
  }
}

@reflector
@jsonSerializable
class RestaurantReview extends BaseReview {
  final String? restaurant;
  late RxList<RestaurantReviewReply> replies;

  RestaurantReview({
    String? id,
    dynamic user,
    String? order,
    int? rating,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalLikes,
    bool? isLiked,
    List<dynamic>? images,
    this.restaurant,
    List<RestaurantReviewReply>? replies,
  })  : replies = (replies ?? []).obs,
        super(
        id: id,
        user: user,
        order: order,
        rating: rating,
        title: title,
        content: content,
        createdAt: createdAt,
        updatedAt: updatedAt,
        totalLikes: totalLikes ?? 0,
        isLiked: isLiked ?? false,
        images: images ?? [],
      );

  RestaurantReview.fromJson(Map<String, dynamic> json)
      : restaurant = json['restaurant'],
        replies = (json['replies'] as List<dynamic>?)
            ?.map((reply) => RestaurantReviewReply.fromJson(reply))
            .toList()
            ?.obs ??
            <RestaurantReviewReply>[].obs,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = super.toJson(patch: patch)..addAll({
      'restaurant': restaurant,
      'replies': replies.map((reply) => reply.toJson()).toList(),
    });

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  Future<dio.FormData> toFormData({bool patch = false}) async {
    dio.FormData formData = await super.toFormData(patch: patch);

    if (restaurant != null) {
      formData.fields.add(MapEntry('restaurant', restaurant!));
    }


    return formData;
  }
}

@reflector
@jsonSerializable
class DelivererReview extends BaseReview {
  final String? deliverer;
  late RxList<DelivererReviewReply> replies;

  DelivererReview({
    String? id,
    dynamic user,
    String? order,
    int? rating,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalLikes,
    bool? isLiked,
    List<dynamic>? images,
    this.deliverer,
    List<DelivererReviewReply>? replies,
  })  : replies = (replies ?? []).obs,
        super(
        id: id,
        user: user,
        order: order,
        rating: rating,
        title: title,
        content: content,
        createdAt: createdAt,
        updatedAt: updatedAt,
        totalLikes: totalLikes ?? 0,
        isLiked: isLiked ?? false,
        images: images ?? [],
      );

  DelivererReview.fromJson(Map<String, dynamic> json)
      : deliverer = json['deliverer'],
        replies = (json['replies'] as List<dynamic>?)
            ?.map((reply) => DelivererReviewReply.fromJson(reply))
            .toList()
            ?.obs ??
            <DelivererReviewReply>[].obs,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = super.toJson(patch: patch)..addAll({
      'deliverer': deliverer,
      'replies': replies.map((reply) => reply.toJson()).toList(),
    });

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  Future<dio.FormData> toFormData({bool patch = false}) async {
    dio.FormData formData = await super.toFormData(patch: patch);

    if (deliverer != null) {
      formData.fields.add(MapEntry('deliverer', deliverer!));
    }


    return formData;
  }
}

@reflector
@jsonSerializable
class DeliveryReview extends BaseReview {
  final String? delivery;
  late RxList<DeliveryReviewReply> replies;

  DeliveryReview({
    String? id,
    dynamic user,
    String? order,
    int? rating,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalLikes,
    bool? isLiked,
    List<dynamic>? images,
    this.delivery,
    List<DeliveryReviewReply>? replies,
  })  : replies = (replies ?? []).obs,
        super(
        id: id,
        user: user,
        order: order,
        rating: rating,
        title: title,
        content: content,
        createdAt: createdAt,
        updatedAt: updatedAt,
        totalLikes: totalLikes ?? 0,
        isLiked: isLiked ?? false,
        images: images ?? [],
      );

  DeliveryReview.fromJson(Map<String, dynamic> json)
      : delivery = json['delivery'],
        replies = (json['replies'] as List<dynamic>?)
            ?.map((reply) => DeliveryReviewReply.fromJson(reply))
            .toList()
            ?.obs ??
            <DeliveryReviewReply>[].obs,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = super.toJson(patch: patch)..addAll({
      'delivery': delivery,
      'replies': replies.map((reply) => reply.toJson()).toList(),
    });

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  Future<dio.FormData> toFormData({bool patch = false}) async {
    dio.FormData formData = await super.toFormData(patch: patch);

    if (delivery != null) {
      formData.fields.add(MapEntry('delivery', delivery!));
    }


    return formData;
  }
}
