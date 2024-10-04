import 'package:dio/dio.dart';
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
  final dynamic image;

  DishCategory({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.dishes,
    this.image,
  });

  DishCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        createdAt = json['create_at'] != null ? DateTime.parse(json['created_at']) : null,
        updatedAt = json['create_at'] != null ? DateTime.parse(json['updated_at']) : null,
        image = json['image'],
        dishes = json['dishes']
  ;

  Future<MultipartFile?> get imageMultipart => THelperFunction.convertXToMultipartFile(image);

  Map<String, dynamic> toJson({ bool patch = false }) {
    Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };

    if(patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  Future<Map<String, dynamic>> toFormData({ bool patch = false }) async {
    Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'image': await imageMultipart
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