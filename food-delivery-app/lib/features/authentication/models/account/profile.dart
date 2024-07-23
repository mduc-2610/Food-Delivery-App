import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class UserProfile {
  final User? user;
  final String? name;
  final String? gender;
  final DateTime? dateOfBirth;

  UserProfile({
    this.user,
    this.name,
    this.gender,
    this.dateOfBirth,
  });

  UserProfile.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['user']),
        name = json['name'],
        gender = json['gender'],
        dateOfBirth = json['date_of_birth'] != null ? DateTime.parse(json['date_of_birth']) : null;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'date_of_birth': dateOfBirth?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('UserProfile', {
      'user': user,
      'name': name,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
    });
  }
}

