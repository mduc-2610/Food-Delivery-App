import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
class BaseLike {
  final String id;
  final String user;
  final DateTime createdAt;

  BaseLike({
    required this.id,
    required this.user,
    required this.createdAt,
  });

  BaseLike.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'],
        createdAt = DateTime.parse(json['created_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class PostLike extends BaseLike {
  final String post;

  PostLike({
    required String id,
    required String user,
    required DateTime createdAt,
    required this.post,
  }) : super(id: id, user: user, createdAt: createdAt);

  PostLike.fromJson(Map<String, dynamic> json)
      : post = json['post'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['post'] = post;
    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class CommentLike extends BaseLike {
  final String comment;

  CommentLike({
    required String id,
    required String user,
    required DateTime createdAt,
    required this.comment,
  }) : super(id: id, user: user, createdAt: createdAt);

  CommentLike.fromJson(Map<String, dynamic> json)
      : comment = json['comment'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['comment'] = comment;
    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
