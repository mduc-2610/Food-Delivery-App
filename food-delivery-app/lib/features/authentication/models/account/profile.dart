import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Profile {
  final User? user;
  final String? name;
  final String? gender;
  final List<UserLocation>? locations;
  final DateTime? dateOfBirth;

  Profile({
    required this.user,
    required this.name,
    this.gender,
    this.locations,
    this.dateOfBirth,
  });

  Profile.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['user']),
        name = json['name'],
        gender = json['gender'],
        locations = (json['locations'] as List<dynamic>?)
            ?.map((item) => UserLocation.fromJson(item))
            .toList(),
        dateOfBirth = json['date_of_birth'] != null ? DateTime.parse(json['date_of_birth']) : null;

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'name': name,
      'gender': gender,
      'locations': locations?.map((location) => location.toJson()).toList(),
      'date_of_birth': dateOfBirth?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Profile', {
      'user': user,
      'name': name,
      'gender': gender,
      'locations': locations,
      'dateOfBirth': dateOfBirth,
    });
  }
}


class UserLocation {
  final String? address;
  final double? latitude;
  final double? longitude;

  UserLocation({this.address, this.latitude, this.longitude});

  UserLocation.fromJson(Map<String, dynamic> json)
      : address = json['address'],
        latitude = json['latitude'],
        longitude = json['longitude'];

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('UserLocation', {
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    });
  }
}
