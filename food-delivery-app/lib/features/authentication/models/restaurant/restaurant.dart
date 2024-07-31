import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/basic_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/detail_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/menu_delivery.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/representative.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Restaurant {
  final String? id;
  final User? user;
  final RestaurantBasicInfo? basicInfo;
  final RestaurantRepresentative? representative;
  final RestaurantDetailInfo? detailInfo;
  final RestaurantMenuDelivery? menuDelivery;
  // final List<RestaurantPromotion>? promotions;

  Restaurant({
    this.id,
    this.user,
    this.basicInfo,
    this.representative,
    this.detailInfo,
    this.menuDelivery,
    // required this.promotions,
  });

  Restaurant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        basicInfo = json['basic_info'] != null ? RestaurantBasicInfo.fromJson(json['basic_info']) : null,
        representative = json['representative'] != null ? RestaurantRepresentative.fromJson(json['representative']) : null,
        detailInfo = json['detail_info'] != null ? RestaurantDetailInfo.fromJson(json['detail_info']) : null,
        menuDelivery = json['menu_delivery'] != null ? RestaurantMenuDelivery.fromJson(json['menu_delivery']) : null
        // promotions = json['promotions'] != null
        //     ? (json['promotions'] as List).map((item) => RestaurantPromotion.fromJson(item)).toList()
        //     : null
      ;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'basic_info': basicInfo?.toJson(),
      'representative': representative?.toJson(),
      'detail_info': detailInfo?.toJson(),
      'menu_delivery': menuDelivery?.toJson(),
      // 'promotions': promotions?.map((promo) => promo.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Restaurant', {
      'id': id,
      'user': user,
      'basicInfo': basicInfo,
      'representative': representative,
      'detailInfo': detailInfo,
      'menuDelivery': menuDelivery,
      // 'promotions': promotions,
    });
  }
}
