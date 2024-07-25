import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SendOTP {
  final PhoneNumber phoneNumber;
  final bool? isForgotPassword;

  SendOTP({
    required this.phoneNumber,
    this.isForgotPassword
  });

  Map<String, dynamic> toJson() {
    return {
      'phone_number': THelperFunction.getPhoneNumber(phoneNumber),
      'is_forgot_password': isForgotPassword ?? false,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('SendOTP', toJson());
  }
}
