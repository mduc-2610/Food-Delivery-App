import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class OperationInfo {
  final String? city;
  final String? operationType;
  final String? operationalArea;
  final String? operationalTime;

  OperationInfo({
    required this.city,
    required this.operationType,
    required this.operationalArea,
    required this.operationalTime,
  });

  OperationInfo.fromJson(Map<String, dynamic> json)
      : city = json['city'],
        operationType = json['operation_type'],
        operationalArea = json['operational_area'],
        operationalTime = json['operational_time'];

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'operation_type': operationType,
      'operational_area': operationalArea,
      'operational_time': operationalTime,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('OperationInfo', {
      'city': city,
      'operationType': operationType,
      'operationalArea': operationalArea,
      'operationalTime': operationalTime,
    });
  }
}
