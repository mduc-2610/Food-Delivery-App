import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class DelivererBasicInfo {
  final String? fullName;
  final String? givenName;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? hometown;
  final String? city;
  final String? district;
  final String? ward;
  final String? address;
  final String? citizenIdentification;

  DelivererBasicInfo({
    this.fullName,
    this.givenName,
    this.gender,
    this.dateOfBirth,
    this.hometown,
    this.city,
    this.district,
    this.ward,
    this.address,
    this.citizenIdentification,
  });

  DelivererBasicInfo.fromJson(Map<String, dynamic> json)
      : fullName = json['full_name'],
        givenName = json['given_name'],
        gender = json['gender'],
        dateOfBirth = DateTime.parse(json['date_of_birth']),
        hometown = json['hometown'],
        city = json['city'],
        district = json['district'],
        ward = json['ward'],
        address = json['address'],
        citizenIdentification = json['citizen_identification'];

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'given_name': givenName,
      'gender': gender,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'hometown': hometown,
      'city': city,
      'district': district,
      'ward': ward,
      'address': address,
      'citizen_identification': citizenIdentification,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}