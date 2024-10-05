import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class BasePromotion {
  final String? id;
  final String? code;
  final String? name;
  final String? description;
  final String? promoType;
  final double? discountPercentage;
  final double? discountAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  bool isDisabled;
  bool isAvailable;
  bool isChosen;

  BasePromotion({
    this.id,
    this.code,
    this.name,
    this.description,
    this.promoType,
    this.discountPercentage,
    this.discountAmount,
    this.startDate,
    this.endDate,
    this.isDisabled = false,
    this.isAvailable = false,
    this.isChosen = false,
  });

  BasePromotion.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        code = json['code'],
        name = json['name'],
        description = json['description'],
        promoType = json['promo_type'],
        discountPercentage = THelperFunction.formatDouble(json['discount_percentage']),
        discountAmount = THelperFunction.formatDouble(json['discount_amount']),
        startDate = DateTime.parse(json['start_date']),
        endDate = DateTime.parse(json['end_date']),
        isDisabled = json['is_disabled'] ?? false,
        isAvailable = json['is_available'] ?? false,
        isChosen = json['is_chosen'] ?? false
  ;

  Map<String, dynamic> toJson({ bool patch = false }) {
    Map<String, dynamic> data = {
      'code': code,
      'name': name,
      'description': description,
      'promo_type': promoType?.toUpperCase(),
      'discount_percentage': discountPercentage,
      'discount_amount': discountAmount,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'is_disabled': isDisabled,
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

@reflector
@jsonSerializable
class RestaurantPromotion extends BasePromotion {
  final dynamic restaurant;

  RestaurantPromotion({
    String? id,
    String? code,
    String? name,
    String? description,
    String? promoType,
    double? discountPercentage,
    double? discountAmount,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    bool? isDisabled,
    bool? isChosen,
    this.restaurant,
  }) : super(
    id: id,
    code: code,
    name: name,
    description: description,
    promoType: promoType,
    discountPercentage: discountPercentage,
    discountAmount: discountAmount,
    startDate: startDate,
    endDate: endDate,
    isAvailable: isActive ?? false,
    isDisabled: isDisabled ?? false,
    isChosen: isChosen ?? false,
  );

  RestaurantPromotion.fromJson(Map<String, dynamic> json)
      : restaurant = json['restaurant'] is String || json['restaurant'] is List || json['restaurant'] == null
          ? json['restaurant']
          : Restaurant.fromJson(json['restaurant']),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson({ bool patch = false }) {
    final data = super.toJson();
    data['restaurant'] = restaurant is Restaurant ? restaurant?.id : restaurant;

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
// @reflector
// @jsonSerializable
// class ActivityPromotion {
//   final String promotionId;
//   final String activityType;
//
//   ActivityPromotion({
//     required this.promotionId,
//     required this.activityType,
//   });
//
//   ActivityPromotion.fromJson(Map<String, dynamic> json)
//       : promotionId = json['promotion'],
//         activityType = json['activity_type'];
//
//   Map<String, dynamic> toJson() {
//     return {
//       'promotion': promotionId,
//       'activity_type': activityType,
//     };
//   }
//
//   @override
//   String toString() {
//     return THelperFunction.formatToString(this);
//   }
// }
