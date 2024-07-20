import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Post {
  final String id;
  final String userId;
  final String title;
  final String content;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Post.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      userId = json['user'],
      title = json['title'],
      content = json['content'],
      createdAt = DateTime.parse(json['created_at']);


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': userId,
      'title': title,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Post', {
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
      'createdAt': createdAt,
    });
  }
}
