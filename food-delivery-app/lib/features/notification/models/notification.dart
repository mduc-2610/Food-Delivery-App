
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Notification {
  final String id;
  final String notificationType;
  final String title;
  final String description;

  Notification({
    required this.id,
    required this.notificationType,
    required this.title,
    required this.description,
  });

  Notification.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        notificationType = json['notification_type'],
        title = json['title'],
        description = json['description'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'notification_type': notificationType,
      'title': title,
      'description': description,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Notification', {
      'id': id,
      'notificationType': notificationType,
      'title': title,
      'description': description,
    });
  }
}
