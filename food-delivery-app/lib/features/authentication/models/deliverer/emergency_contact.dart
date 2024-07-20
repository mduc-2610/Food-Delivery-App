import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class EmergencyContact {
  final String? name;
  final String? relationship;
  final String? phoneNumber;

  EmergencyContact({
    required this.name,
    required this.relationship,
    required this.phoneNumber,
  });

  EmergencyContact.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        relationship = json['relationship'],
        phoneNumber = json['phone_number'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'relationship': relationship,
      'phone_number': phoneNumber,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('EmergencyContact', {
      'name': name,
      'relationship': relationship,
      'phoneNumber': phoneNumber,
    });
  }
}
