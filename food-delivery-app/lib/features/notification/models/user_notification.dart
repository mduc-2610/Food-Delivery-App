
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@jsonSerializable
class UserNotification {
  final String? id;
  final String? userId;
  final String? notificationId;
  final DateTime? timestamp;
  final bool? readStatus;

  UserNotification({
    this.id,
    this.userId,
    this.notificationId,
    this.timestamp,
    this.readStatus,
  });

  UserNotification.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user'],
        notificationId = json['notification'],
        timestamp = DateTime.parse(json['timestamp']),
        readStatus = json['read_status'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': userId,
      'notification': notificationId,
      'timestamp': timestamp?.toIso8601String(),
      'read_status': readStatus,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('UserNotification', {
      'id': id,
      'userId': userId,
      'notificationId': notificationId,
      'timestamp': timestamp,
      'readStatus': readStatus,
    });
  }
}