import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/main.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@jsonSerializable
class Dish {
  final String? id;
  final String? name;
  final String? description;
  final double? originalPrice;
  final double? discountPrice;
  final String? imageUrl;
  final double? rating;
  final int? numberOfReviews;
  final String? categoryId;

  Dish({
    this.id,
    this.name,
    this.description,
    this.originalPrice,
    this.discountPrice,
    this.imageUrl,
    this.rating,
    this.numberOfReviews,
    this.categoryId,
  });

  Dish.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        originalPrice = double.parse(json['original_price']),
        discountPrice = double.parse(json['discount_price']),
        imageUrl = json['image'],
        rating = double.parse(json['rating']),
        numberOfReviews = json['number_of_reviews'],
        categoryId = json['category'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'original_price': originalPrice,
      'discount_price': discountPrice,
      'image': imageUrl,
      'rating': rating,
      'number_of_reviews': numberOfReviews,
      'category': categoryId,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Dish', {
      'id': id,
      'name': name,
      'description': description,
      'originalPrice': originalPrice,
      'discountPrice': discountPrice,
      'imageUrl': imageUrl,
      'rating': rating,
      'numberOfReviews': numberOfReviews,
      'categoryId': categoryId,
    });
  }
}