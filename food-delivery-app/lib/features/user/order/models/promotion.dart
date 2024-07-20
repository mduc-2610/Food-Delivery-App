import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Promotion {
  final String id;
  final String code;
  final String description;
  final String promoType;
  final double? discountPercentage;
  final double? discountAmount;
  final DateTime startDate;
  final DateTime endDate;
  final String applicableScope;
  final String termsAndConditions;
  final bool active;

  Promotion({
    required this.id,
    required this.code,
    required this.description,
    required this.promoType,
    this.discountPercentage,
    this.discountAmount,
    required this.startDate,
    required this.endDate,
    required this.applicableScope,
    required this.termsAndConditions,
    required this.active,
  });

  Promotion.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        code = json['code'],
        description = json['description'],
        promoType = json['promo_type'],
        discountPercentage = json['discount_percentage']?.toDouble(),
        discountAmount = json['discount_amount']?.toDouble(),
        startDate = DateTime.parse(json['start_date']),
        endDate = DateTime.parse(json['end_date']),
        applicableScope = json['applicable_scope'],
        termsAndConditions = json['terms_and_conditions'],
        active = json['active'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'promo_type': promoType,
      'discount_percentage': discountPercentage,
      'discount_amount': discountAmount,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'applicable_scope': applicableScope,
      'terms_and_conditions': termsAndConditions,
      'active': active,
    };
  }

  bool isActive() {
    final now = DateTime.now();
    return active && startDate.isBefore(now) && endDate.isAfter(now);
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Promotion', {
      'id': id,
      'code': code,
      'description': description,
      'promoType': promoType,
      'discountPercentage': discountPercentage,
      'discountAmount': discountAmount,
      'startDate': startDate,
      'endDate': endDate,
      'applicableScope': applicableScope,
      'termsAndConditions': termsAndConditions,
      'active': active,
    });
  }
}

class ActivityPromotion {
  final String promotionId;
  final String activityType;

  ActivityPromotion({
    required this.promotionId,
    required this.activityType,
  });

  ActivityPromotion.fromJson(Map<String, dynamic> json)
      : promotionId = json['promotion'],
        activityType = json['activity_type'];

  Map<String, dynamic> toJson() {
    return {
      'promotion': promotionId,
      'activity_type': activityType,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('ActivityPromotion', {
      'promotionId': promotionId,
      'activityType': activityType,
    });
  }
}
