import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Dish {
  final String id;
  final String name;
  final String description;
  final double originalPrice;
  final double? discountPrice;
  final String? imageUrl;
  final double rating;
  final int numberOfReviews;
  final String categoryId;

  Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.originalPrice,
    this.discountPrice,
    this.imageUrl,
    required this.rating,
    required this.numberOfReviews,
    required this.categoryId,
  });

  Dish.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        originalPrice = (json['original_price'] as num).toDouble(),
        discountPrice = json['discount_price'] != null
            ? (json['discount_price'] as num).toDouble()
            : null,
        imageUrl = json['image'],
        rating = (json['rating'] as num).toDouble(),
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