import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

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
    required this.fullName,
    required this.givenName,
    required this.gender,
    required this.dateOfBirth,
    required this.hometown,
    required this.city,
    required this.district,
    required this.ward,
    required this.address,
    required this.citizenIdentification,
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
    return THelperFunction.formatToString('BasicInfo', {
      'fullName': fullName,
      'givenName': givenName,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'hometown': hometown,
      'city': city,
      'district': district,
      'ward': ward,
      'address': address,
      'citizenIdentification': citizenIdentification,
    });
  }
}