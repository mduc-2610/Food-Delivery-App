import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class DelivererEmergencyContact {
  String? deliverer;
  final String? name;
  final String? relationship;
  final String? phoneNumber;

  DelivererEmergencyContact({
    this.deliverer,
    this.name,
    this.relationship,
    this.phoneNumber,
  });

  DelivererEmergencyContact.fromJson(Map<String, dynamic> json)
      : deliverer = json['deliverer'],
        name = json['name'],
        relationship = json['relationship'],
        phoneNumber = json['phone_number'];

  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = {
      'deliverer': deliverer,
      'name': name,
      'relationship': relationship,
      'phone_number': phoneNumber,
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
