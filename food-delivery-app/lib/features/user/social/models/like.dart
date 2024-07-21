import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class BaseLike {
  final String id;
  final String userId;
  final DateTime createdAt;

  BaseLike({
    required this.id,
    required this.userId,
    required this.createdAt,
  });

  BaseLike.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user'],
        createdAt = DateTime.parse(json['created_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': userId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('BaseLike', {
      'id': id,
      'userId': userId,
      'createdAt': createdAt,
    });
  }
}

class PostLike extends BaseLike {
  final String postId;

  PostLike({
    required String id,
    required String userId,
    required DateTime createdAt,
    required this.postId,
  }) : super(id: id, userId: userId, createdAt: createdAt);

  PostLike.fromJson(Map<String, dynamic> json)
      : postId = json['post'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['post'] = postId;
    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString('PostLike', {
      'id': id,
      'userId': userId,
      'createdAt': createdAt,
      'postId': postId,
    });
  }
}

class CommentLike extends BaseLike {
  final String commentId;

  CommentLike({
    required String id,
    required String userId,
    required DateTime createdAt,
    required this.commentId,
  }) : super(id: id, userId: userId, createdAt: createdAt);

  CommentLike.fromJson(Map<String, dynamic> json)
      : commentId = json['comment'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['comment'] = commentId;
    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString('CommentLike', {
      'id': id,
      'userId': userId,
      'createdAt': createdAt,
      'commentId': commentId,
    });
  }
}
