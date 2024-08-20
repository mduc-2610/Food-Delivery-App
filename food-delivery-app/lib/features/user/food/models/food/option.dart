
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class DishOption {
  final String? id;
  final String? dish;
  final String? name;
  final List<DishOptionItem> items;

  DishOption({
    this.id,
    this.dish,
    this.name,
    this.items = const [],
  });

  DishOption.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dish = json['dish'],
        name = json['name'],
        items = json['items'] != null ? json['items'] is List ? (json['items'] as List).map((instance) => DishOptionItem.fromJson(instance)).toList() : [] : [];

  String get formattedName {
    return THelperFunction.formatName(name ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dish': dish,
      'name': name,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class DishOptionItem {
  final String? id;
  final String? option;
  final String? name;
  final double? price;

  DishOptionItem({
    this.id,
    this.option,
    this.name,
    this.price,
  });

  DishOptionItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        option = json['option'],
        name = json['name'],
        price = double.parse(json['price']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dish': option,
      'name': name,
      'price': price,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
