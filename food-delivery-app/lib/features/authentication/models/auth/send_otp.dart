import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SendOTP {
  final PhoneNumber phoneNumber;

  SendOTP({
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone_number': THelperFunction.getPhoneNumber(phoneNumber),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('SendOTP', toJson());
  }
}
