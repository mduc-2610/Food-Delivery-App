
import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/user/food/models/review/review_image.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class BaseReviewReply {
  final String? id;
  final dynamic user;
  final String? title;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic> images;

  BaseReviewReply({
    this.id,
    this.user,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.images = const [],
  });

  BaseReviewReply.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'],
        title = json['title'],
        content = json['content'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        images = List<ReviewImage>.from(json['images'] ?? []);

  Map<String, dynamic> toJson({ bool patch = false }) {
    Map<String, dynamic> data = {
      'id': id,
      'user': user,
      'title': title,
      'content': content,
    };

    if(patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  Future<List<dynamic>> get multiPartImages async {
    bool getStrUrl = true;
    return await THelperFunction.convertListToMultipartFile(images, mediaType: 'jpeg', getStrUrl: getStrUrl);
  }


  Future<FormData> toFormData({bool patch = false}) async {
    var [_multiPartImages, _imageUrls] = await multiPartImages;
    Map<String, dynamic> data = {
      'id': id,
      'user': user,
      'title': title,
      'content': content,
      'images': _multiPartImages,
      'image_urls_delete': _imageUrls
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
  final String? review;

  DishReviewReply({
    String? id,
    String? user,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<dynamic> images = const [],
    this.review,
  }) : super(
    id: id,
    user: user,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    images: images,
  );

  DishReviewReply.fromJson(Map<String, dynamic> json)
      : review = json['review'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson({ bool patch = false }) {
    final data = super.toJson();
    data['review'] = review;

    if(patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@jsonSerializable
@reflector
class RestaurantReviewReply extends BaseReviewReply {
  final String? review;

  RestaurantReviewReply({
    String? id,
    String? user,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<dynamic> images = const [],
    this.review,
  }) : super(
    id: id,
    user: user,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    images: images,
  );

  RestaurantReviewReply.fromJson(Map<String, dynamic> json)
      : review = json['review'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson({ bool patch = false }) {
    final data = super.toJson();
    data['review'] = review;

    if(patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }


  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@jsonSerializable
@reflector
class DelivererReviewReply extends BaseReviewReply {
  final String? review;

  DelivererReviewReply({
    String? id,
    String? user,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<dynamic> images = const [],
    this.review,
  }) : super(
    id: id,
    user: user,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    images: images,
  );

  DelivererReviewReply.fromJson(Map<String, dynamic> json)
      : review = json['review'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson({ bool patch = false }) {
    final data = super.toJson();
    data['review'] = review;

    if(patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }


  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@jsonSerializable
@reflector
class DeliveryReviewReply extends BaseReviewReply {
  final String? review;

  DeliveryReviewReply({
    String? id,
    String? user,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<dynamic> images = const [],
    this.review,
  }) : super(
    id: id,
    user: user,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    images: images,
  );

  DeliveryReviewReply.fromJson(Map<String, dynamic> json)
      : review = json['review'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson({ bool patch = false }) {
    final data = super.toJson();
    data['review'] = review;

    if(patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }


  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}