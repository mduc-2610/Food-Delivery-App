import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@jsonSerializable
class Post {
  final String? id;
  final UserAbbr? user;
  final String? title;
  final String? content;
  final DateTime? createdAt;

  Post({
    this.id,
    this.user,
    this.title,
    this.content,
    this.createdAt,
  });

  Post.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      user = UserAbbr.fromJson(json['user']),
      title = json['title'],
      content = json['content'],
      createdAt = DateTime.parse(json['created_at']);


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.id,
      'title': title,
      'content': content,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Post', {
      'id': id,
      'user': user,
      'title': title,
      'content': content,
      'createdAt': createdAt,
    });
  }
}
