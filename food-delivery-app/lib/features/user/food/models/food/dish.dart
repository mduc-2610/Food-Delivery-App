import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/user/food/models/food/category.dart';
import 'package:food_delivery_app/features/user/food/models/food/option.dart';
import 'package:food_delivery_app/main.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:image_picker/image_picker.dart';

@reflector
@jsonSerializable
class Dish {
  final String? id;
  final String? name;
  final String? description;
  final double originalPrice;
  final double discountPrice;
  final dynamic image;
  final double? rating;
  final int? totalReviews;
  int totalLikes;
  final int? totalOrders;
  bool? isDisabled;
  final dynamic category;
  final String? dishReviews;
  final Map<String, dynamic> ratingCounts;
  final List<DishOption> options;
  final String? inCartsOrOrders;
  final List<dynamic> images;
  final String? restaurant;
  final bool isLiked;

  Dish({
    this.id,
    this.name,
    this.description,
    this.originalPrice = 0,
    this.discountPrice = 0,
    this.image,
    this.rating,
    this.totalReviews,
    this.totalLikes = 0,
    this.totalOrders,
    this.isDisabled,
    this.category,
    this.dishReviews,
    this.ratingCounts = const {},
    this.options = const [],
    this.inCartsOrOrders,
    this.images = const [],
    this.restaurant,
    this.isLiked = false,
  });

  Dish.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        restaurant = json['restaurant'],
        name = json['name'],
        description = json['description'],
        originalPrice = json['original_price'] != null ? double.parse(json['original_price']) : 0,
        discountPrice = json['discount_price'] != null ? double.parse(json['discount_price']) : 0,
        image = json['image'],
        rating = THelperFunction.formatDouble(json['rating']),
        totalReviews = json['total_reviews'],
        totalLikes = json['total_likes'] ?? 0,
        totalOrders = json['total_orders'],
        isDisabled = json['is_disabled'],
        category = json['category'] is String || json['category'] == null || json['category'] is List
            ? json['category'] : DishCategory.fromJson(json['category']),
        dishReviews = json['dish_reviews'],
        ratingCounts = json['rating_counts'] ?? {},
        options = json['options'] != null ? json['options'] is List ? (json['options'] as List).map((instance) => DishOption.fromJson(instance)).toList() : [] : [],
        inCartsOrOrders = json['in_carts_or_orders'],
        images = json['images'] != null ? (json['images'] as List<dynamic>).map((instance) => DishImage.fromJson(instance)).toList() : [],
        isLiked = json['is_liked'] ?? false
  ;

  String get formattedName {
    return THelperFunction.formatName(name ?? "");
  }

  Map<String, dynamic> toJson({ bool patch = false }) {
    Map<String, dynamic> data = {
      'restaurant': restaurant,
      'name': name,
      'description': description,
      'original_price': originalPrice,
      'discount_price': discountPrice,
      'rating': rating ?? 0,
      'is_disabled': isDisabled,
      'category': category,
    };

    if(patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  Future<MultipartFile?> get multiPartImage =>
      THelperFunction.convertXToMultipartFile(image, mediaType: 'jpeg');

  Future<List<dynamic>> get multiPartImages async {
    bool getStrUrl = true;
    return await THelperFunction.convertListToMultipartFile(images, mediaType: 'jpeg', getStrUrl: getStrUrl);
  }


  Future<FormData> toFormData({bool patch = false}) async {
    var [_multiPartImages, _imageUrls] = await multiPartImages;
    Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'original_price': originalPrice,
      'discount_price': discountPrice,
      'image': await multiPartImage,
      'images': _multiPartImages,
      'image_urls': _imageUrls,
      'rating': rating ?? 0,
      'is_disabled': isDisabled,
      'category': category,
      'restaurant': restaurant,
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return FormData.fromMap(data);
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


@reflector
@jsonSerializable
class DishImage {
  String? id;
  String? image;
  String? dish;

  DishImage({
    this.id,
    this.image,
    this.dish,
  });

  DishImage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'],
        dish = json['dish'];


  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
