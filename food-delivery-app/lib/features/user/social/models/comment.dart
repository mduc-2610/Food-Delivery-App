import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@jsonSerializable
class Comment {
  final String? id;
  final String? post;
  final String? user;
  final String? text;
  final DateTime? createdAt;

  Comment({
    this.id,
    this.post,
    this.user,
    this.text,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      post: json['post'],
      user: json['user'],
      text: json['text'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post': post,
      'user': user,
      'text': text,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Comment', {
      'id': id,
      'post': post,
      'user': user,
      'text': text,
      'createdAt': createdAt,
    });
  }
}
