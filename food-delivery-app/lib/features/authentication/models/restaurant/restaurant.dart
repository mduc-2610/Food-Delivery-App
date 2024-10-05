import 'package:flutter/foundation.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/basic_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/detail_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/menu_delivery.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/payment_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/representative_info.dart';
import 'package:food_delivery_app/features/user/food/models/food/category.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/models/review/review.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class Restaurant {
  final String? id;
  final String? user;
  final RestaurantBasicInfo? basicInfo;
  final RestaurantRepresentativeInfo? representativeInfo;
  final RestaurantDetailInfo? detailInfo;
  final RestaurantMenuDelivery? menuDelivery;
  final RestaurantPaymentInfo? paymentInfo;
  final List<DishCategory> categories;
  final dynamic dishes;
  final double rating;
  final double avgPrice;
  final int? totalReviews;
  final String? restaurantReviews;
  final Map<String, dynamic> ratingCounts;
  final bool isCertified;
  final String? stats;
  final String? deliveries;
  final bool isLiked;
  int totalLikes;
  final String? restaurantCategories;
  final String? promotions;
  // final List<RestaurantPromotion>? promotions;

  Restaurant({
    this.id,
    this.user,
    this.basicInfo,
    this.detailInfo,
    this.paymentInfo,
    this.representativeInfo,
    this.menuDelivery,
    this.dishes = const [],
    this.categories = const [],
    this.rating = 0,
    this.avgPrice = 0,
    this.totalReviews,
    this.restaurantReviews,
    this.ratingCounts = const {},
    this.isCertified = false,
    this.stats,
    this.deliveries,
    this.isLiked = false,
    this.totalLikes = 0,
    this.restaurantCategories,
    this.promotions,
    // required this.promotions,
  });

  Restaurant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'],
        basicInfo = json['basic_info'] != null ? RestaurantBasicInfo.fromJson(json['basic_info']) : null,
        representativeInfo = json['representative_info'] != null ? RestaurantRepresentativeInfo.fromJson(json['representative_info']) : null,
        detailInfo = json['detail_info'] != null ? RestaurantDetailInfo.fromJson(json['detail_info']) : null,
        menuDelivery = json['menu_delivery'] != null ? RestaurantMenuDelivery.fromJson(json['menu_delivery']) : null,
        paymentInfo = json['payment_info'] != null ? RestaurantPaymentInfo.fromJson(json['payment_info']) : null,
        categories = json['categories'] != null ? (json['categories'] as List).map((instance) => DishCategory.fromJson(instance)).toList() : [],
        dishes = json['dishes'] != null ?
            json['dishes'] is String ? json['dishes'] :
              (json['dishes'] as List).map((instance) => Dish.fromJson(instance)).toList() : [],
        rating = THelperFunction.formatDouble(json['rating']),
        avgPrice = THelperFunction.formatDouble(json['avg_price']),
        totalReviews = json['total_reviews'],
        restaurantReviews = json['restaurant_reviews'],
        ratingCounts = json['rating_counts'] ?? {},
        isCertified = json['is_certified'] ?? false,
        stats = json['stats'],
        deliveries = json['deliveries'],
        isLiked = json['is_liked'] ?? false,
        totalLikes = json['total_likes'] ?? 0,
        restaurantCategories = json['restaurant_categories'],
        promotions = json['promotions']
        ;


  Map<String, dynamic> toJson({ bool patch = false}) {
    Map<String, dynamic> data = {
      'id': id,
      'user': user,
      'basic_info': basicInfo?.toJson(),
      'representative_info': representativeInfo?.toJson(),
      'detail_info': detailInfo?.toJson(),
      'menu_delivery': menuDelivery?.toJson(),
    };

    if(patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  String get formatTotalReviews {
    return THelperFunction.formatNumber(totalReviews ?? 0);
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@jsonSerializable
@reflector
class RestaurantLike {
  final String? id;
  final String? restaurant;
  final String? user;
  final DateTime? createdAt;

  RestaurantLike({
    this.id,
    this.restaurant,
    this.user,
    this.createdAt,
  });

  RestaurantLike.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      restaurant = json['restaurant'],
      user = json['user'],
      createdAt = json['createdAt'] != null ? DateTime.parse(json['created_at']) : null
  ;

  Map<String, dynamic> toJson({ bool patch = false}) {
    Map<String, dynamic> data = {
      'user': user,
      'restaurant': restaurant,
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


@jsonSerializable
@reflector
class RestaurantCategory {
  final String? id;
  final dynamic restaurant;
  final dynamic category;
  final DateTime? createdAt;
  final bool isDisabled;

  RestaurantCategory({
    this.id,
    this.restaurant,
    this.category,
    this.createdAt,
    this.isDisabled = false,
  });

  RestaurantCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        restaurant = json['restaurant'] is List || json['restaurant'] is String || json['restaurant'] == null
            ? json['restaurant']
            : DishCategory.fromJson(json['restaurant']),
        category = json['category'] is List || json['category'] is String || json['category'] == null
            ? json['category']
            : DishCategory.fromJson(json['category']),
        createdAt = json['createdAt'] != null ? DateTime.parse(json['created_at']) : null,
        isDisabled = json['is_disabled'] ?? false
  ;

  Map<String, dynamic> toJson({ bool patch = false}) {
    Map<String, dynamic> data = {
      'category': category is DishCategory ? category?.id : category,
      'restaurant': restaurant is Restaurant ? restaurant?.id : restaurant,
      'is_disabled': isDisabled
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
