
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class Notification {
  final String? id;
  final String? notificationType;
  final String? title;
  final String? description;

  Notification({
    this.id,
    this.notificationType,
    this.title,
    this.description,
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
    return THelperFunction.formatToString(this);
  }
}
