import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class DishLike {
  final String id;
  final String userId;
  final String dishId;
  final DateTime createdAt;

  DishLike({
    required this.id,
    required this.userId,
    required this.dishId,
    required this.createdAt,
  });

  DishLike.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user'],
        dishId = json['dish'],
        createdAt = DateTime.parse(json['created_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': userId,
      'dish': dishId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('DishLike', {
      'id': id,
      'userId': userId,
      'dishId': dishId,
      'createdAt': createdAt,
    });
  }
}