import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class DelivererResidencyInfo {
  final bool? isSameAsCi;
  final String? city;
  final String? district;
  final String? ward;
  final String? address;
  final String? taxCode;
  final String? email;

  DelivererResidencyInfo({
    required this.isSameAsCi,
    required this.city,
    required this.district,
    required this.ward,
    required this.address,
    required this.taxCode,
    required this.email,
  });

  DelivererResidencyInfo.fromJson(Map<String, dynamic> json)
      : isSameAsCi = json['is_same_as_ci'],
        city = json['city'],
        district = json['district'],
        ward = json['ward'],
        address = json['address'],
        taxCode = json['tax_code'],
        email = json['email'];

  Map<String, dynamic> toJson() {
    return {
      'is_same_as_ci': isSameAsCi,
      'city': city,
      'district': district,
      'ward': ward,
      'address': address,
      'tax_code': taxCode,
      'email': email,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('DelivererResidencyInfo', {
      'isSameAsCi': isSameAsCi,
      'city': city,
      'district': district,
      'ward': ward,
      'address': address,
      'taxCode': taxCode,
      'email': email,
    });
  }
}
