import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class BaseImage {
  final String id;
  final String imageUrl;
  final DateTime createdAt;

  BaseImage({
    required this.id,
    required this.imageUrl,
    required this.createdAt,
  });

  BaseImage.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      imageUrl = json['image'],
      createdAt = DateTime.parse(json['created_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': imageUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('BaseImage', {
      'id': id,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    });
  }
}

class PostImage extends BaseImage {
  final String postId;

  PostImage({
    required String id,
    required String imageUrl,
    required DateTime createdAt,
    required this.postId,
  }) : super(id: id, imageUrl: imageUrl, createdAt: createdAt);

  PostImage.fromJson(Map<String, dynamic> json)
    : postId = json['post'],
      super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['post'] = postId;
    return json;
  }

  @override
  String toString() {
    return THelperFunction.formatToString('PostImage', {
      'id': id,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'postId': postId,
    });
  }
}

class CommentImage extends BaseImage {
  final String commentId;

  CommentImage({
    required String id,
    required String imageUrl,
    required DateTime createdAt,
    required this.commentId,
  }) : super(id: id, imageUrl: imageUrl, createdAt: createdAt);

  CommentImage.fromJson(Map<String, dynamic> json)
    : commentId = json['comment'],
      super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['comment'] = commentId;
    return json;
  }

  @override
  String toString() {
    return THelperFunction.formatToString('CommentImage', {
      'id': id,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'commentId': commentId,
    });
  }
}
