import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Address {
  final String? city;
  final String? district;
  final String? ward;
  final String? detailAddress;

  Address({
    required this.city,
    required this.district,
    required this.ward,
    required this.detailAddress,
  });

  Address.fromJson(Map<String, dynamic> json)
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
    return THelperFunction.formatToString('Address', {
      'city': city,
      'district': district,
      'ward': ward,
      'detailAddress': detailAddress,
    });
  }
}
