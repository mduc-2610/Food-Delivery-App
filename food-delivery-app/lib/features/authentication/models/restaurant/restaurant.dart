import 'package:flutter/foundation.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/basic_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/detail_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/menu_delivery.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/representative.dart';
import 'package:food_delivery_app/features/user/food/models/food/category.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class Restaurant {
  final String? id;
  final String? user;
  final RestaurantBasicInfo? basicInfo;
  final RestaurantRepresentative? representative;
  final RestaurantDetailInfo? detailInfo;
  final RestaurantMenuDelivery? menuDelivery;
  final List<DishCategory> categories;
  final dynamic dishes;
  final double? rating;
  final int? totalReviews;
  // final List<RestaurantPromotion>? promotions;

  Restaurant({
    this.id,
    this.user,
    this.basicInfo,
    this.representative,
    this.detailInfo,
    this.menuDelivery,
    this.dishes = const [],
    this.categories = const [],
    this.rating,
    this.totalReviews,
    // required this.promotions,
  });

  Restaurant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'],
        basicInfo = json['basic_info'] != null ? RestaurantBasicInfo.fromJson(json['basic_info']) : null,
        representative = json['representative'] != null ? RestaurantRepresentative.fromJson(json['representative']) : null,
        detailInfo = json['detail_info'] != null ? RestaurantDetailInfo.fromJson(json['detail_info']) : null,
        menuDelivery = json['menu_delivery'] != null ? RestaurantMenuDelivery.fromJson(json['menu_delivery']) : null,
        // promotions = json['promotions'] != null
        //     ? (json['promotions'] as List).map((item) => RestaurantPromotion.fromJson(item)).toList()
        //     : null
        categories = json['categories'] != null ? (json['categories'] as List).map((instance) => DishCategory.fromJson(instance)).toList() : [],
        dishes = json['dishes'] != null ?
            json['dishes'] is String ? json['dishes'] :
              (json['dishes'] as List).map((instance) => Dish.fromJson(instance)).toList() : [],
        rating = json['rating'] != null ? double.parse(json['rating']) : 0,
        totalReviews = json['total_reviews']
      ;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'basic_info': basicInfo?.toJson(),
      'representative': representative?.toJson(),
      'detail_info': detailInfo?.toJson(),
      'menu_delivery': menuDelivery?.toJson(),
      // 'promotions': promotions?.map((promo) => promo.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
