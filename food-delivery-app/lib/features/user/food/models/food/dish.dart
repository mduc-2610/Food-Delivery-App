import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/user/food/models/food/option.dart';
import 'package:food_delivery_app/main.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class Dish {
  final String? id;
  final String? name;
  final String? description;
  final double originalPrice;
  final double discountPrice;
  final String? image;
  final double? rating;
  final int? totalReviews;
  final int? totalLikes;
  final String? categoryId;
  final String? dishReviews;
  final Map<String, dynamic> ratingCounts;
  final List<DishOption> options;

  Dish({
    this.id,
    this.name,
    this.description,
    this.originalPrice = 0,
    this.discountPrice = 0,
    this.image,
    this.rating,
    this.totalReviews,
    this.totalLikes,
    this.categoryId,
    this.dishReviews,
    this.ratingCounts = const {},
    this.options = const [],
  });

  Dish.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        originalPrice = json['original_price'] != null ? double.parse(json['original_price']) : 0,
        discountPrice = json['discount_price'] != null ? double.parse(json['discount_price']) : 0,
        image = json['image'],
        rating = double.parse(json['rating']),
        totalReviews = json['total_reviews'],
        totalLikes = json['total_likes'],
        categoryId = json['category'],
        dishReviews = json['dish_reviews'],
        ratingCounts = json['rating_counts'] ?? {},
        options = json['options'] != null ? json['options'] is List ? (json['options'] as List).map((instance) => DishOption.fromJson(instance)).toList() : [] : [];

  String get formattedName {
    return THelperFunction.formatName(name ?? "");
  }

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