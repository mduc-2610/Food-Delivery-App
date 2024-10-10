
import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/food/models/review/review_image.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class BaseReviewReply {
  final String? id;
  final dynamic user;
  final String? title;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? review;
  final List<dynamic> images;

  BaseReviewReply({
    this.id,
    this.user,
    this.title,
    this.content,
    this.createdAt,
    this.review,
    this.updatedAt,
    this.images = const [],
  });

  BaseReviewReply.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] is String || json['user'] == null || json['user'] is List
          ? json['user']
          : BasicUser.fromJson(json['user']),
        title = json['title'],
        content = json['content'],
        review = json['review'],
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt = json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
        images = (json['images'] as List<dynamic>?)?.map((image) => ReviewImage.fromJson(image)).toList() ?? [];

  Map<String, dynamic> toJson({ bool patch = false }) {
    Map<String, dynamic> data = {
      'id': id,
      'user': user is BasicUser || user is User ? user?.id : user,
      'title': title,
      'content': content,
      'review': review,
    };

    if(patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  Future<List<dynamic>> get multiPartImages async {
    bool getStrUrl = true;
    return await THelperFunction.convertListToMultipartFile(images, getStrUrl: getStrUrl);
  }

  Future<FormData> toFormData({bool patch = false}) async {
    var [_multiPartImages, _imageUrls] = await multiPartImages;
    Map<String, dynamic> data = {
      'id': id,
      'user': user is BasicUser || user is User ? user?.id : user,
      'title': title,
      'content': content,
      'review': review,
      'images': _multiPartImages,
      'image_urls': _imageUrls
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return FormData.fromMap(data);
  }
}

@jsonSerializable
@reflector
class DishReviewReply extends BaseReviewReply {
  DishReviewReply({
    String? id,
    dynamic user,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? review,
    List<dynamic> images = const [],
  }) : super(
    id: id,
    user: user,
    review: review,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    images: images,
  );

  DishReviewReply.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@jsonSerializable
@reflector
class RestaurantReviewReply extends BaseReviewReply {
  RestaurantReviewReply({
    String? id,
    dynamic user,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? review,
    List<dynamic> images = const [],
  }) : super(
    id: id,
    user: user,
    review: review,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    images: images,
  );

  RestaurantReviewReply.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);


  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@jsonSerializable
@reflector
class DelivererReviewReply extends BaseReviewReply {
  DelivererReviewReply({
    String? id,
    dynamic user,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? review,
    List<dynamic> images = const [],
  }) : super(
    id: id,
    user: user,
    review: review,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    images: images,
  );

  DelivererReviewReply.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);


  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@jsonSerializable
@reflector
class DeliveryReviewReply extends BaseReviewReply {
  DeliveryReviewReply({
    String? id,
    dynamic user,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? review,
    List<dynamic> images = const [],
  }) : super(
    id: id,
    user: user,
    review: review,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    images: images,
  );

  DeliveryReviewReply.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);


  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}