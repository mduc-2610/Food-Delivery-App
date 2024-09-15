
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@reflector
@jsonSerializable
class Delivery {
  final String? id;
  final dynamic order;
  final dynamic user;
  final dynamic restaurant;
  final dynamic deliverer;
  final String? pickupLocation;
  final double pickUpLatitude;
  final double pickUpLongitude;
  final String? dropOffLocation;
  final double dropOffLatitude;
  final double dropOffLongitude;
  final String? status;
  final DateTime? estimatedDeliveryTime;
  final DateTime? actualDeliveryTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Delivery({
    this.id,
    this.order,
    this.user,
    this.restaurant,
    this.deliverer,
    this.pickupLocation,
    this.pickUpLatitude = 0,
    this.pickUpLongitude = 0,
    this.dropOffLocation,
    this.dropOffLatitude = 0,
    this.dropOffLongitude = 0,
    this.status,
    this.estimatedDeliveryTime,
    this.actualDeliveryTime,
    this.createdAt,
    this.updatedAt,
  });

  Delivery.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        order = json['order'] == null || json['order'] is String ? json['order'] : Order.fromJson(json['order']),
        user = json['user'] == null || json['user'] is String ? json['user'] : BasicUser.fromJson(json['user']),
        restaurant = json['restaurant'] == null || json['restaurant'] is String ? json['restaurant'] : Restaurant.fromJson(json['restaurant']),
        deliverer = json['deliverer'] == null || json['deliverer'] is String ? json['deliverer'] : Deliverer.fromJson(json['deliverer']),
        pickupLocation = json['pickup_location'],
        pickUpLatitude = THelperFunction.formatDouble(json['pickup_latitude']),
        pickUpLongitude = THelperFunction.formatDouble(json['pickup_longitude']),
        dropOffLocation = json['dropoff_location'],
        dropOffLatitude = THelperFunction.formatDouble(json['dropoff_latitude']),
        dropOffLongitude = THelperFunction.formatDouble(json['dropoff_longitude']),
        status = json['status'],
        estimatedDeliveryTime = json['estimated_delivery_time'] != null ? DateTime.parse(json['estimated_delivery_time']) : null,
        actualDeliveryTime = json['actual_delivery_time'] != null ? DateTime.parse(json['actual_delivery_time']) : null,
        createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
        updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;

  LatLng get pickupCoordinate {
    return LatLng(pickUpLatitude, pickUpLongitude);
  }

  LatLng get dropOffCoordinate {
    return LatLng(dropOffLatitude, dropOffLongitude);
  }

  String get formatEstimatedDeliveryTime {
    return THelperFunction.formatTime(estimatedDeliveryTime ?? DateTime.now());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': order is String ? order : order?.toJson(),
      'deliverer': deliverer is String ? deliverer : deliverer?.toJson(),
      'pickup_location': pickupLocation,
      'pickup_latitude': pickUpLatitude,
      'pickup_longitude': pickUpLongitude,
      'dropoff_location': dropOffLocation,
      'dropoff_latitude': dropOffLatitude,
      'dropoff_longitude': dropOffLongitude,
      'status': status,
      'estimated_delivery_time': estimatedDeliveryTime?.toIso8601String(),
      'actual_delivery_time': actualDeliveryTime?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class DeliveryRequest {
  final String? id;
  final dynamic deliverer;
  final dynamic delivery;
  final dynamic user;
  final String? status;
  final DateTime? expiredAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? respondedAt;
  final String? accept;
  final String? decline;
  final String? complete;

  DeliveryRequest({
    this.id,
    this.deliverer,
    this.delivery,
    this.user,
    this.status,
    this.expiredAt,
    this.createdAt,
    this.updatedAt,
    this.respondedAt,
    this.accept,
    this.decline,
    this.complete,
  });

  DeliveryRequest.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        deliverer = json['deliverer'] == null || json['deliverer'] is String
            ? json['deliverer']
            : Deliverer.fromJson(json['deliverer']),
        delivery = json['delivery'] == null || json['delivery'] is String
            ? json['delivery']
            : Delivery.fromJson(json['delivery']),
        user = json['user'] == null || json['user'] is String
            ? json['user']
            : BasicUser.fromJson(json['user']),
        status = json['status'],
        expiredAt = json['expired_at'] != null ? DateTime.parse(json['expired_at']) : null,
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        respondedAt = json['responded_at'] != null ? DateTime.parse(json['responded_at']) : null,
        accept = json['accept'],
        decline = json['decline'],
        complete = json['complete']
  ;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deliverer': deliverer is String ? deliverer : deliverer?.toJson(),
      'delivery': delivery is String ?  delivery : delivery?.toJson(),
      'status': status,
      'expired_at': expiredAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'responded_at': respondedAt?.toIso8601String(),
      'accept': accept,
      'decline': decline,
      'complete': complete,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}