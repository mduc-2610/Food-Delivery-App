import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
class BaseImage {
  final String? id;
  final String? imageUrl;
  final DateTime? createdAt;

  BaseImage({
    this.id,
    this.imageUrl,
    this.createdAt,
  });

  BaseImage.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      imageUrl = json['image'],
      createdAt = DateTime.parse(json['created_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': imageUrl,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class PostImage extends BaseImage {
  final String? post;

  PostImage({
    String? id,
    String? imageUrl,
    DateTime? createdAt,
    this.post,
  }) : super(id: id, imageUrl: imageUrl, createdAt: createdAt);

  PostImage.fromJson(Map<String, dynamic> json)
    : post = json['post'],
      super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['post'] = post;
    return json;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class CommentImage extends BaseImage {
  final String? comment;

  CommentImage({
    String? id,
    String? imageUrl,
    DateTime? createdAt,
    this.comment,
  }) : super(id: id, imageUrl: imageUrl, createdAt: createdAt);

  CommentImage.fromJson(Map<String, dynamic> json)
    : comment = json['comment'],
      super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['comment'] = comment;
    return json;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
