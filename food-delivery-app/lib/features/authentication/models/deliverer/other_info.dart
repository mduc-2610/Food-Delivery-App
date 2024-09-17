import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

@reflector
@jsonSerializable
class DelivererOtherInfo {
  final String? occupation;
  final String? details;
  final dynamic judicialRecord;

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
      'judicial_record': judicialRecord is XFile ? judicialRecord.path : judicialRecord,
    };
  }

  Future<MultipartFile?> get multiPartJudicialRecord => THelperFunction.convertXToMultipartFile(judicialRecord, mediaType: 'jpeg');

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'occupation': occupation,
      'details': details,
      'judicial_record': await multiPartJudicialRecord,
    });
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
