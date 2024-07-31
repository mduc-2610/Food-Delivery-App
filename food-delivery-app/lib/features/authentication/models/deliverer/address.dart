import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class DelivererAddress {
  final String? city;
  final String? district;
  final String? ward;
  final String? detailAddress;

  DelivererAddress({
    this.city,
    this.district,
    this.ward,
    this.detailAddress,
  });

  DelivererAddress.fromJson(Map<String, dynamic> json)
      : city = json['city'],
        district = json['district'],
        ward = json['ward'],
        detailAddress = json['detail_address'];

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'district': district,
      'ward': ward,
      'detail_address': detailAddress,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
