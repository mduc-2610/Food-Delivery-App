import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

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
    return THelperFunction.formatToString('RMessage', toJson());
  }
}