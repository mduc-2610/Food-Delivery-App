import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class DishCategory {
  final String? id;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? dishes;

  DishCategory({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.dishes
  });

  DishCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        dishes = json['dishes'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}