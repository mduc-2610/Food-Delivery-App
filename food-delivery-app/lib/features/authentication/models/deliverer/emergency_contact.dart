import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class DelivererEmergencyContact {
  final String? name;
  final String? relationship;
  final String? phoneNumber;

  DelivererEmergencyContact({
    required this.name,
    required this.relationship,
    required this.phoneNumber,
  });

  DelivererEmergencyContact.fromJson(Map<String, dynamic> json)
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
    return THelperFunction.formatToString('DelivererEmergencyContact', {
      'name': name,
      'relationship': relationship,
      'phoneNumber': phoneNumber,
    });
  }
}
