import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class DishLike {
  final String? id;
  final dynamic user;
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
        user = json['user'] == null || json['user'] is String || json['user'] is List
          ? json['user']
          : BasicUser.fromJson(json['user']),
        dish = json['dish'],
        createdAt = DateTime.parse(json['created_at']);

  Map<String, dynamic> toJson({ bool patch = false }) {
    Map<String, dynamic> data = {
      'id': id,
      'user': (user is BasicUser) ? user?.id : user,
      'dish': dish,
      'created_at': createdAt?.toIso8601String(),
    };

    if(patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}