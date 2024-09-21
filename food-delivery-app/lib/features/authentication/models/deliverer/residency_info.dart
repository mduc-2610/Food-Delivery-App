import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class DelivererResidencyInfo {
  String? deliverer;
  final bool? isSameAsCI;
  final String? city;
  final String? district;
  final String? ward;
  final String? address;
  final String? taxCode;
  final String? email;

  DelivererResidencyInfo({
    this.deliverer,
    this.isSameAsCI,
    this.city,
    this.district,
    this.ward,
    this.address,
    this.taxCode,
    this.email,
  });

  DelivererResidencyInfo.fromJson(Map<String, dynamic> json)
      : deliverer = json['deliverer'],
        isSameAsCI = json['is_same_as_ci'],
        city = json['city'],
        district = json['district'],
        ward = json['ward'],
        address = json['address'],
        taxCode = json['tax_code'],
        email = json['email'];

  Map<String, dynamic> toJson({bool patch = false}) {
    final data = {
      'deliverer': deliverer,
      'is_same_as_ci': isSameAsCI,
      'city': city,
      'district': district,
      'ward': ward,
      'address': address,
      'tax_code': taxCode,
      'email': email,
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
