import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class OtherInfo {
  final String? occupation;
  final String? details;
  final String? judicialRecord;

  OtherInfo({
    required this.occupation,
    required this.details,
    required this.judicialRecord,
  });

  OtherInfo.fromJson(Map<String, dynamic> json)
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
    return THelperFunction.formatToString('OtherInfo', {
      'occupation': occupation,
      'details': details,
      'judicialRecord': judicialRecord,
    });
  }
}
