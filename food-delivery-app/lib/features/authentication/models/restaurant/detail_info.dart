import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@jsonSerializable
class RestaurantDetailInfo {
  final Map<String, dynamic>? openingHours;
  final String? keywords;
  final String? description;
  final String? avatarImage;
  final String? coverImage;
  final String? facadeImage;
  final String? restaurantType;
  final String? cuisine;
  final String? specialtyDishes;
  final String? servingTimes;
  final String? targetAudience;
  final String? restaurantCategory;
  final String? purpose;

  RestaurantDetailInfo({
    this.openingHours,
    this.keywords,
    this.description,
    this.avatarImage,
    this.coverImage,
    this.facadeImage,
    this.restaurantType,
    this.cuisine,
    this.specialtyDishes,
    this.servingTimes,
    this.targetAudience,
    this.restaurantCategory,
    this.purpose,
  });

  RestaurantDetailInfo.fromJson(Map<String, dynamic> json)
      : openingHours = json['opening_hours'],
        keywords = json['keywords'],
        description = json['description'],
        avatarImage = json['avatar_image'],
        coverImage = json['cover_image'],
        facadeImage = json['facade_image'],
        restaurantType = json['restaurant_type'],
        cuisine = json['cuisine'],
        specialtyDishes = json['specialty_dishes'],
        servingTimes = json['serving_times'],
        targetAudience = json['target_audience'],
        restaurantCategory = json['restaurant_category'],
        purpose = json['purpose'];

  Map<String, dynamic> toJson() {
    return {
      'opening_hours': openingHours,
      'keywords': keywords,
      'description': description,
      'avatar_image': avatarImage,
      'cover_image': coverImage,
      'facade_image': facadeImage,
      'restaurant_type': restaurantType,
      'cuisine': cuisine,
      'specialty_dishes': specialtyDishes,
      'serving_times': servingTimes,
      'target_audience': targetAudience,
      'restaurant_category': restaurantCategory,
      'purpose': purpose,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('RestaurantDetailInfo', {
      'openingHours': openingHours,
      'keywords': keywords,
      'description': description,
      'avatarImage': avatarImage,
      'coverImage': coverImage,
      'facadeImage': facadeImage,
      'restaurantType': restaurantType,
      'cuisine': cuisine,
      'specialtyDishes': specialtyDishes,
      'servingTimes': servingTimes,
      'targetAudience': targetAudience,
      'restaurantCategory': restaurantCategory,
      'purpose': purpose,
    });
  }
}
