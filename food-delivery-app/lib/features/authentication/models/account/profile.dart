import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Profile {
  final User? user;
  final String? name;
  final String? gender;
  final String? location;
  final DateTime? dateOfBirth;

  Profile({
    required this.user,
    required this.name,
    this.gender,
    this.location,
    this.dateOfBirth,
  });

  Profile.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['user']),
        name = json['name'],
        gender = json['gender'],
        location = json['location'],
        dateOfBirth = json['date_of_birth'] != null ? DateTime.parse(json['date_of_birth']) : null;

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'name': name,
      'gender': gender,
      'location': location,
      'date_of_birth': dateOfBirth?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('Profile', {
      'user': user,
      'name': name,
      'gender': gender,
      'location': location,
      'dateOfBirth': dateOfBirth,
    });
  }
}
