import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class DelivererOperationInfo {
  String? deliverer;
  final String? city;
  final String? driverType;
  final String? area;
  final String? time;
  final String? hub;

  DelivererOperationInfo({
    this.deliverer,
    this.city,
    this.driverType,
    this.area,
    this.time,
    this.hub
  });

  DelivererOperationInfo.fromJson(Map<String, dynamic> json)
      : deliverer = json['deliverer'],
        city = json['city'],
        driverType = json['driver_type'],
        area = json['area'],
        time = json['time'],
        hub = json['hub'];

  String get convertDriverType {
    if(driverType?.toLowerCase().contains("hub") ?? false) {
      return "HUB";
    }
    return "PART_TIME";
  }

  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = {
      'deliverer': deliverer,
      'city': city,
      'driver_type': convertDriverType,
      'area': area,
      'time': time,
      'hub': hub,
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
