import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Like {
  final String id;
  final String postId;
  final String userId;
  final DateTime createdAt;

  Like({
    required this.id,
    required this.postId,
    required this.userId,
    required this.createdAt,
  });

  Like.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      postId = json['post'],
      userId = json['user'],
      createdAt = DateTime.parse(json['created_at']);


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post': postId,
      'user': userId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Like', {
      'id': id,
      'postId': postId,
      'userId': userId,
      'createdAt': createdAt,
    });
  }
}
