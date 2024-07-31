import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class DelivererOtherInfo {
  final String? occupation;
  final String? details;
  final String? judicialRecord;

  DelivererOtherInfo({
    this.occupation,
    this.details,
    this.judicialRecord,
  });

  DelivererOtherInfo.fromJson(Map<String, dynamic> json)
      : occupation = json['occupation'],
        details = json['details'],
        judicialRecord = json['judicial_record'];

  Map<String, dynamic> toJson() {
    return {
      'occupation': occupation,
      'details': details,
      'judicial_record': judicialRecord,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
