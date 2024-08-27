
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class Delivery {
  final String id;
  final dynamic order;
  final String? deliverer;
  final String pickupLocation;
  final double? pickupLatitude;
  final double? pickupLongitude;
  final String dropOffLocation;
  final double? dropOffLatitude;
  final double? dropOffLongitude;
  final String status;
  final DateTime? estimatedDeliveryTime;
  final DateTime? actualDeliveryTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Delivery({
    required this.id,
    required this.order,
    this.deliverer,
    required this.pickupLocation,
    this.pickupLatitude,
    this.pickupLongitude,
    required this.dropOffLocation,
    this.dropOffLatitude,
    this.dropOffLongitude,
    required this.status,
    this.estimatedDeliveryTime,
    this.actualDeliveryTime,
    required this.createdAt,
    required this.updatedAt,
  });

  Delivery.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        order = json['order'] == null || json['order'] is String ? json['order'] : Order.fromJson(json['order']),
        deliverer = json['deliverer'],
        pickupLocation = json['pickup_location'],
        pickupLatitude = THelperFunction.formatDouble(json['pickup_latitude']),
        pickupLongitude = THelperFunction.formatDouble(json['pickup_longitude']),
        dropOffLocation = json['dropoff_location'],
        dropOffLatitude = THelperFunction.formatDouble(json['dropoff_latitude']),
        dropOffLongitude = THelperFunction.formatDouble(json['dropoff_longitude']),
        status = json['status'],
        estimatedDeliveryTime = json['estimated_delivery_time'] != null ? DateTime.parse(json['estimated_delivery_time']) : null,
        actualDeliveryTime = json['actual_delivery_time'] != null ? DateTime.parse(json['actual_delivery_time']) : null,
        createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
        updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': order,
      'deliverer': deliverer,
      'pickup_location': pickupLocation,
      'pickup_lat': pickupLatitude,
      'pickup_long': pickupLongitude,
      'dropoff_location': dropOffLocation,
      'dropoff_lat': dropOffLatitude,
      'dropoff_long': dropOffLongitude,
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
