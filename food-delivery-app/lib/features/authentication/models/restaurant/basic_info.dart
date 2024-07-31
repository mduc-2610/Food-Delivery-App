import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class RestaurantBasicInfo {
  final String? name;
  final String? phoneNumber;
  final String? city;
  final String? district;
  final String? streetAddress;
  final String? mapLocation;

  RestaurantBasicInfo({
    this.name,
    this.phoneNumber,
    this.city,
    this.district,
    this.streetAddress,
    this.mapLocation,
  });

  RestaurantBasicInfo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phoneNumber = json['phone_number'],
        city = json['city'],
        district = json['district'],
        streetAddress = json['street_address'],
        mapLocation = json['map_location'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'city': city,
      'district': district,
      'street_address': streetAddress,
      'map_location': mapLocation,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
