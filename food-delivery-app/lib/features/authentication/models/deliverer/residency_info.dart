import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@jsonSerializable
class DelivererResidencyInfo {
  final bool? isSameAsCi;
  final String? city;
  final String? district;
  final String? ward;
  final String? address;
  final String? taxCode;
  final String? email;

  DelivererResidencyInfo({
    this.isSameAsCi,
    this.city,
    this.district,
    this.ward,
    this.address,
    this.taxCode,
    this.email,
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
