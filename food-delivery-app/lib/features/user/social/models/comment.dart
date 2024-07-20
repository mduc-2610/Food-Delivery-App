import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Comment {
  final String id;
  final String postId;
  final String userId;
  final String text;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.text,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['post'],
      userId: json['user'],
      text: json['text'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post': postId,
      'user': userId,
      'text': text,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Comment', {
      'id': id,
      'postId': postId,
      'userId': userId,
      'text': text,
      'createdAt': createdAt,
    });
  }
}
