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
  final String? address;
  final String? addressName;
  final double? latitude;
  final double? longitude;

  RestaurantBasicInfo({
    this.restaurant,
    this.name,
    this.phoneNumber,
    this.city,
    this.district,
    this.address,
    this.addressName,
    this.latitude,
    this.longitude,
  });

  RestaurantBasicInfo.fromJson(Map<String, dynamic> json)
      : restaurant = json['restaurant'],
        name = json['name'],
        phoneNumber = json['phone_number'],
        city = json['city'],
        district = json['district'],
        address = json['address'],
        addressName = json['address_name'],
        latitude = json['latitude'] == null ? json['latitude'] : THelperFunction.formatDouble(json['latitude']),
        longitude = json['longitude'] == null ? json['longitude'] : THelperFunction.formatDouble(json['longitude'])
  ;

  Map<String, dynamic> toJson({bool patch = false}) {
    final data = {
      'restaurant': restaurant,
      'name': name,
      'phone_number': phoneNumber,
      'city': city,
      'district': district,
      'address': address,
      'address_name': addressName,
      'latitude': latitude?.toStringAsFixed(6),
      'longitude': longitude?.toStringAsFixed(6),
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
