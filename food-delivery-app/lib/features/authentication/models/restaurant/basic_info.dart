import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class RestaurantBasicInfo {
  String? restaurant;
  final String? name;
  final String? phoneNumber;
  final String? city;
  final String? district;
  final String? streetAddress;
  final String? mapLocation;

  RestaurantBasicInfo({
    this.restaurant,
    this.name,
    this.phoneNumber,
    this.city,
    this.district,
    this.streetAddress,
    this.mapLocation,
  });

  RestaurantBasicInfo.fromJson(Map<String, dynamic> json)
      : restaurant = json['restaurant'],
        name = json['name'],
        phoneNumber = json['phone_number'],
        city = json['city'],
        district = json['district'],
        streetAddress = json['street_address'],
        mapLocation = json['map_location'];

  Map<String, dynamic> toJson({bool patch = false}) {
    final data = {
      'restaurant': restaurant,
      'name': name,
      'phone_number': phoneNumber,
      'city': city,
      'district': district,
      'street_address': streetAddress,
      'map_location': mapLocation,
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
