
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class Delivery {
  final String id;
  final String orderId;
  final String? delivererId;
  final String pickupLocation;
  final double? pickupLat;
  final double? pickupLong;
  final String dropOffLocation;
  final double? dropOffLat;
  final double? dropOffLong;
  final String status;
  final DateTime? estimatedDeliveryTime;
  final DateTime? actualDeliveryTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  Delivery({
    required this.id,
    required this.orderId,
    this.delivererId,
    required this.pickupLocation,
    this.pickupLat,
    this.pickupLong,
    required this.dropOffLocation,
    this.dropOffLat,
    this.dropOffLong,
    required this.status,
    this.estimatedDeliveryTime,
    this.actualDeliveryTime,
    required this.createdAt,
    required this.updatedAt,
  });

  Delivery.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        orderId = json['order'],
        delivererId = json['deliverer'],
        pickupLocation = json['pickup_location'],
        pickupLat = json['pickup_lat']?.toDouble(),
        pickupLong = json['pickup_long']?.toDouble(),
        dropOffLocation = json['dropoff_location'],
        dropOffLat = json['dropoff_lat']?.toDouble(),
        dropOffLong = json['dropoff_long']?.toDouble(),
        status = json['status'],
        estimatedDeliveryTime = json['estimated_delivery_time'] != null ? DateTime.parse(json['estimated_delivery_time']) : null,
        actualDeliveryTime = json['actual_delivery_time'] != null ? DateTime.parse(json['actual_delivery_time']) : null,
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': orderId,
      'deliverer': delivererId,
      'pickup_location': pickupLocation,
      'pickup_lat': pickupLat,
      'pickup_long': pickupLong,
      'dropoff_location': dropOffLocation,
      'dropoff_lat': dropOffLat,
      'dropoff_long': dropOffLong,
      'status': status,
      'estimated_delivery_time': estimatedDeliveryTime?.toIso8601String(),
      'actual_delivery_time': actualDeliveryTime?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
