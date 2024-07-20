import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/basic_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/detail_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/menu_delivery.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/representative.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Restaurant {
  final String id;
  final User? user;
  final BasicInfo? basicInfo;
  final Representative? representative;
  final DetailInfo? detailInfo;
  final MenuDelivery? menuDelivery;
  // final List<RestaurantPromotion>? promotions;

  Restaurant({
    required this.id,
    required this.user,
    required this.basicInfo,
    required this.representative,
    required this.detailInfo,
    required this.menuDelivery,
    // required this.promotions,
  });

  Restaurant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        basicInfo = json['basic_info'] != null ? BasicInfo.fromJson(json['basic_info']) : null,
        representative = json['representative'] != null ? Representative.fromJson(json['representative']) : null,
        detailInfo = json['detail_info'] != null ? DetailInfo.fromJson(json['detail_info']) : null,
        menuDelivery = json['menu_delivery'] != null ? MenuDelivery.fromJson(json['menu_delivery']) : null
        // promotions = json['promotions'] != null
        //     ? (json['promotions'] as List).map((item) => RestaurantPromotion.fromJson(item)).toList()
        //     : null
      ;

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'user': user?.toJson(),
  //     'basic_info': basicInfo?.toJson(),
  //     'representative': representative?.toJson(),
  //     'detail_info': detailInfo?.toJson(),
  //     'menu_delivery': menuDelivery?.toJson(),
  //     // 'promotions': promotions?.map((promo) => promo.toJson()).toList(),
  //   };
  // }

  // String name() {
  //   return basicInfo?.name ?? '';
  // }

  // String description() {
  //   return detailInfo?.description ?? '';
  // }

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
