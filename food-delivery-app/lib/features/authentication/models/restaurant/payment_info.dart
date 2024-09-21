import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class RestaurantPaymentInfo {
  String? restaurant;
  final String? email;
  final String? phoneNumber;
  final String? citizenIdentification;
  final String? accountName;
  final String? accountNumber;
  final String? bank;
  final String? city;
  final String? branch;

  RestaurantPaymentInfo({
    this.restaurant,
    this.email,
    this.phoneNumber,
    this.citizenIdentification,
    this.accountName,
    this.accountNumber,
    this.bank,
    this.city,
    this.branch,
  });

  RestaurantPaymentInfo.fromJson(Map<String, dynamic> json)
      : restaurant = json['restaurant'],
        email = json['email'],
        phoneNumber = json['phone_number'],
        citizenIdentification = json['citizen_identification'],
        accountName = json['account_name'],
        accountNumber = json['account_number'],
        bank = json['bank'],
        city = json['city'],
        branch = json['branch'];

  Map<String, dynamic> toJson({bool patch = false}) {
    final data = {
      'restaurant': restaurant,
      'email': email,
      'phone_number': phoneNumber,
      'citizen_identification': citizenIdentification,
      'account_name': accountName,
      'account_number': accountNumber,
      'bank': bank,
      'city': city,
      'branch': branch,
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
