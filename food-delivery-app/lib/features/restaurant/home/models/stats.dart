import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@jsonSerializable
@reflector
class StatsResponse {
  final String type;
  final List<StatEntry> data;

  StatsResponse({
    required this.type,
    required this.data,
  });

  factory StatsResponse.fromJson(Map<String, dynamic> json) {
    return StatsResponse(
      type: json['type'] as String,
      data: (json['data'] as List<dynamic>).map((e) {
        return StatEntry.fromJson(e as Map<String, dynamic>);
      }).toList(),
    );
  }

  Map<String, dynamic> toJson({bool patch = false}) {
    final map = {
      'type': type,
      'data': data.map((e) => e.toJson()).toList(),
    };

    if (patch) {
      map.removeWhere((key, value) => value == null);
    }

    return map;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@jsonSerializable
@reflector
class StatEntry {
  final String? day;
  final String? month;
  final String? timeRange;
  final int totalOrders;
  final double totalSales;

  StatEntry({
    this.day,
    this.month,
    this.timeRange,
    this.totalOrders = 0,
    this.totalSales = 0.0,
  });

  factory StatEntry.fromJson(Map<String, dynamic> json) {
    return StatEntry(
      day: json['day'] as String?,
      month: json['month'] as String?,
      timeRange: json['time_range'] as String?,
      totalOrders: json['total_orders'],
      totalSales: THelperFunction.formatDouble(json['total_sales']),
    );
  }

  Map<String, dynamic> toJson({bool patch = false}) {
    final map = <String, dynamic>{
      'day': day,
      'month': month,
      'time_range': timeRange,
      'total_orders': totalOrders,
      'total_sales': totalSales,
    };

    if (patch) {
      map.removeWhere((key, value) => value == null);
    }

    return map;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
