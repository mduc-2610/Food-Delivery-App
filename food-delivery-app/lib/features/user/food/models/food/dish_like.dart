import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@jsonSerializable
class DishLike {
  final String? id;
  final UserAbbr? user;
  final String? dish;
  final DateTime? createdAt;

  DishLike({
    this.id,
    this.user,
    this.dish,
    this.createdAt,
  });

  DishLike.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = UserAbbr.fromJson(json['user']),
        dish = json['dish'],
        createdAt = DateTime.parse(json['created_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.id,
      'dish': dish,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('DishLike', {
      'id': id,
      'user': user?.toJson(),
      'dish': dish,
      'createdAt': createdAt,
    });
  }
}