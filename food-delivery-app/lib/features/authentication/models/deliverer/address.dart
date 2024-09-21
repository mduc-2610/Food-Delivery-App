import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class DelivererAddress {
  final String? deliverer;
  final String? city;
  final String? district;
  final String? ward;
  final String? detailAddress;

  DelivererAddress({
    this.deliverer,
    this.city,
    this.district,
    this.ward,
    this.detailAddress,
  });

  DelivererAddress.fromJson(Map<String, dynamic> json)
      : deliverer = json['deliverer'],
        city = json['city'],
        district = json['district'],
        ward = json['ward'],
        detailAddress = json['detail_address'];

  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = {
      'city': city,
      'district': district,
      'ward': ward,
      'detail_address': detailAddress,
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
