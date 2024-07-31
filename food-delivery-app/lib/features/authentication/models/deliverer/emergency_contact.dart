import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@jsonSerializable
class DelivererEmergencyContact {
  final String? name;
  final String? relationship;
  final String? phoneNumber;

  DelivererEmergencyContact({
    this.name,
    this.relationship,
    this.phoneNumber,
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
