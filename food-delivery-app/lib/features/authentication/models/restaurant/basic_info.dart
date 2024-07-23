import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class RestaurantBasicInfo {
  final String? name;
  final String? phoneNumber;
  final String? city;
  final String? district;
  final String? streetAddress;
  final String? mapLocation;

  RestaurantBasicInfo({
    required this.name,
    required this.phoneNumber,
    required this.city,
    required this.district,
    required this.streetAddress,
    required this.mapLocation,
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
    return THelperFunction.formatToString('RestaurantBasicInfo', {
      'name': name,
      'phoneNumber': phoneNumber,
      'city': city,
      'district': district,
      'streetAddress': streetAddress,
      'mapLocation': mapLocation,
    });
  }
}
