import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/address.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/basic_info.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/driver_license.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/emergency_contact.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/operation_info.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/other_info.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/residency_info.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@reflector
@jsonSerializable
class Deliverer {
  final String? id;
  final dynamic user;
  final DelivererBasicInfo? basicInfo;
  final DelivererResidencyInfo? residencyInfo;
  final DelivererDriverLicense? driverLicense;
  final DelivererOtherInfo? otherInfo;
  final DelivererAddress? address;
  final DelivererOperationInfo? operationInfo;
  final DelivererEmergencyContact? emergencyContact;
  final String? deliveries;
  final String? delivererReviews;
  final String? deliveryRequests;
  final String? requests;
  final double rating;
  final int totalReviews;
  final Map<String, dynamic> ratingCounts;
  double currentLatitude;
  double currentLongitude;
  final String? avatar;
  final bool isActive;
  final bool isOccupied;

  Deliverer({
    this.id,
    this.user,
    this.basicInfo,
    this.residencyInfo,
    this.driverLicense,
    this.otherInfo,
    this.address,
    this.operationInfo,
    this.emergencyContact,
    this.deliveries,
    this.delivererReviews,
    this.deliveryRequests,
    this.requests,
    this.rating = 0,
    this.totalReviews = 0,
    this.ratingCounts = const {},
    this.currentLatitude = 0,
    this.currentLongitude = 0,
    this.avatar,
    this.isActive = false,
    this.isOccupied = false,
  });

  Deliverer.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = json['user'] == null || json['user'] is String ? json['user'] : User.fromJson(json['user']),
        basicInfo = json['basic_info'] != null ? DelivererBasicInfo.fromJson(json['basic_info']) : null,
        residencyInfo = json['residency_info'] != null ? DelivererResidencyInfo.fromJson(json['residency_info']) : null,
        driverLicense = json['driver_license'] != null ? DelivererDriverLicense.fromJson(json['driver_license']) : null,
        otherInfo = json['other_info'] != null ? DelivererOtherInfo.fromJson(json['other_info']) : null,
        address = json['address'] != null ? DelivererAddress.fromJson(json['address']) : null,
        operationInfo = json['operation_info'] != null ? DelivererOperationInfo.fromJson(json['operation_info']) : null,
        emergencyContact = json['emergency_contact'] != null ? DelivererEmergencyContact.fromJson(json['emergency_contact']) : null,
        deliveries = json['deliveries'],
        delivererReviews = json['deliverer_reviews'],
        deliveryRequests = json['delivery_requests'],
        requests = json['requests'],
        rating = THelperFunction.formatDouble(json['rating']),
        totalReviews = json['total_reviews'] ?? 0,
        ratingCounts = json['rating_counts'] ?? {},
        currentLatitude = THelperFunction.formatDouble(json['current_latitude']),
        currentLongitude = THelperFunction.formatDouble(json['current_longitude']),
        avatar = json['avatar'],
        isActive = json['is_active'] ?? false,
        isOccupied = json['is_occupied'] ?? false
  ;

  LatLng get currentCoordinate {
    return LatLng(currentLatitude, currentLongitude);
  }

  set currentCoordinate(LatLng newCoordinate) {
    currentLatitude = newCoordinate.latitude;
    currentLongitude = newCoordinate.longitude;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'basic_info': basicInfo?.toJson(),
      'residency_info': residencyInfo?.toJson(),
      'driver_license': driverLicense?.toJson(),
      'other_info': otherInfo?.toJson(),
      'address': address?.toJson(),
      'operation_info': operationInfo?.toJson(),
      'emergency_contact': emergencyContact?.toJson(),
    };
  }

  String get formatTotalReviews {
    return THelperFunction.formatNumber(totalReviews ?? 0);
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
