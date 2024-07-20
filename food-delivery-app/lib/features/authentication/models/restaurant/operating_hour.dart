import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class OperatingHour {
  final String? detailInformationId;
  final String? dayOfWeek;
  final String? openTime;
  final String? closeTime;

  OperatingHour({
    required this.detailInformationId,
    required this.dayOfWeek,
    required this.openTime,
    required this.closeTime,
  });

  OperatingHour.fromJson(Map<String, dynamic> json)
      : detailInformationId = json['detail_information'],
        dayOfWeek = json['day_of_week'],
        openTime = json['open_time'],
        closeTime = json['close_time'];

  Map<String, dynamic> toJson() {
    return {
      'detail_information': detailInformationId,
      'day_of_week': dayOfWeek,
      'open_time': openTime,
      'close_time': closeTime,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('OperatingHour', {
      'detailInformationId': detailInformationId,
      'dayOfWeek': dayOfWeek,
      'openTime': openTime,
      'closeTime': closeTime,
    });
  }
}
