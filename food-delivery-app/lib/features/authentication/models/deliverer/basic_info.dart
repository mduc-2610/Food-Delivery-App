import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:intl/intl.dart'; // Add this import

@reflector
@jsonSerializable
class DelivererBasicInfo {
  String? deliverer;
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
    this.deliverer,
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
      : deliverer = json['deliverer'],
        fullName = json['full_name'],
        givenName = json['given_name'],
        gender = json['gender'],
        dateOfBirth = json['date_of_birth'] is String
            ? DateTime.parse(json['date_of_birth'])
            : json['date_of_birth'],
        hometown = json['hometown'],
        city = json['city'],
        district = json['district'],
        ward = json['ward'],
        address = json['address'],
        citizenIdentification = json['citizen_identification'];

  String get convertGender {
    if (gender == "Nữ") {
      return "FEMALE";
    } else if (gender == "Nam") {
      return "MALE";
    }
    return gender?.toUpperCase() ?? "";
  }

  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = {
      'deliverer': deliverer,
      'full_name': fullName,
      'given_name': givenName,
      'gender': convertGender,
      'date_of_birth': dateOfBirth != null
          ? DateFormat('yyyy-MM-dd').format(dateOfBirth!)
          : null,
      'hometown': hometown,
      'city': city,
      'district': district,
      'ward': ward,
      'address': address,
      'citizen_identification': citizenIdentification,
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
