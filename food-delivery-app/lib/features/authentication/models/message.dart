import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class RMessage {
  final String message;

  RMessage({
    required this.message,
  });

  RMessage.fromJson(Map<String, dynamic> json)
    : message = json["message"];

  Map<String, dynamic> toJson() {
    return {
      'message': message
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}