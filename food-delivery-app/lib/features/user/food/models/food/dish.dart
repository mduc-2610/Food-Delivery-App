import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/main.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class Dish {
  final String? id;
  final String? name;
  final String? description;
  final double? originalPrice;
  final double? discountPrice;
  final String? image;
  final double? rating;
  final int? totalReviews;
  final int? totalLikes;
  final String? categoryId;
  final String? dishReviews;
  final Map<String, dynamic> ratingCounts;

  Dish({
    this.id,
    this.name,
    this.description,
    this.originalPrice,
    this.discountPrice,
    this.image,
    this.rating,
    this.totalReviews,
    this.totalLikes,
    this.categoryId,
    this.dishReviews,
    this.ratingCounts = const {},
  });

  Dish.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        originalPrice = double.parse(json['original_price']),
        discountPrice = double.parse(json['discount_price']),
        image = json['image'],
        rating = double.parse(json['rating']),
        totalReviews = json['total_reviews'],
        totalLikes = json['total_likes'],
        categoryId = json['category'],
        dishReviews = json['dish_reviews'],
        ratingCounts = json['rating_counts'] ?? {};

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'original_price': originalPrice,
      'discount_price': discountPrice,
      'image': image,
      'rating': rating,
      'total_reviews': totalReviews,
      'total_likes': totalLikes,
      'category': categoryId,
    };
  }

  String get formatTotalReviews {
    return THelperFunction.formatNumber(totalReviews ?? 0);
  }
  
  Map<String, dynamic> get formatRatingCounts {
    return ratingCounts.map((key, value) => MapEntry(key, THelperFunction.formatNumber(value)));
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}