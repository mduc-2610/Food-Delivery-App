
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class DishAdditionalOption {
  final String id;
  final String dishId;
  final String name;
  final double price;

  DishAdditionalOption({
    required this.id,
    required this.dishId,
    required this.name,
    required this.price,
  });

  DishAdditionalOption.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dishId = json['dish'],
        name = json['name'],
        price = (json['price'] as num).toDouble();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dish': dishId,
      'name': name,
      'price': price,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('DishAdditionalOption', {
      'id': id,
      'dishId': dishId,
      'name': name,
      'price': price,
    });
  }
}

class DishSizeOption {
  final String id;
  final String dishId;
  final String size;
  final double price;

  DishSizeOption({
    required this.id,
    required this.dishId,
    required this.size,
    required this.price,
  });

  DishSizeOption.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dishId = json['dish'],
        size = json['size'],
        price = (json['price'] as num).toDouble();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dish': dishId,
      'size': size,
      'price': price,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('DishSizeOption', {
      'id': id,
      'dishId': dishId,
      'size': size,
      'price': price,
    });
  }
}
