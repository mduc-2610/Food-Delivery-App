import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

@reflector
@jsonSerializable
class LoginPassword {
  final PhoneNumber phoneNumber;
  final String password;

  LoginPassword({
    required this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone_number': THelperFunction.getPhoneNumber(phoneNumber),
      'password': password,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
