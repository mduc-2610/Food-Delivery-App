
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@jsonSerializable
class DishAdditionalOption {
  final String? id;
  final String? dishId;
  final String? name;
  final double? price;

  DishAdditionalOption({
    this.id,
    this.dishId,
    this.name,
    this.price,
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

@jsonSerializable
class DishSizeOption {
  final String? id;
  final String? dishId;
  final String? size;
  final double? price;

  DishSizeOption({
    this.id,
    this.dishId,
    this.size,
    this.price,
  });

  DishSizeOption.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dishId = json['dish'],
        size = json['size'],
        price = double.parse(json['price']);

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
