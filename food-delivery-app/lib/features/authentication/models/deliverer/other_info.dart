import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

@reflector
@jsonSerializable
class DelivererOtherInfo {
  String? deliverer;
  final String? occupation;
  final String? details;
  final dynamic judicialRecord;

  DelivererOtherInfo({
    this.deliverer,
    this.occupation,
    this.details,
    this.judicialRecord,
  });

  DelivererOtherInfo.fromJson(Map<String, dynamic> json)
      : deliverer = json['deliverer'],
        occupation = json['occupation'],
        details = json['details'],
        judicialRecord = json['judicial_record'];

  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = {
      'deliverer': deliverer,
      'occupation': occupation,
      'details': details,
      'judicial_record': judicialRecord is XFile ? judicialRecord.path : judicialRecord,
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }


  Future<MultipartFile?> get multiPartJudicialRecord => THelperFunction.convertXToMultipartFile(judicialRecord, mediaType: 'jpeg');

  Future<FormData> toFormData({bool patch = false}) async {
    final data = {
      'deliverer': deliverer,
      'occupation': occupation,
      'details': details,
      'judicial_record': await multiPartJudicialRecord,
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return FormData.fromMap(data);
  }


  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
