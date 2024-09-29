import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@jsonSerializable
@reflector
class StatsResponse {
  final String type;
  final double overallTotalRevenue;
  final int overallTotalOrders;
  final int overallTotalCancelled;
  final double overallCancelRate;
  final double overallAverageOrderValue;
  final List<StatEntry> data;

  StatsResponse({
    required this.type,
    required this.overallTotalRevenue,
    required this.overallTotalOrders,
    required this.overallTotalCancelled,
    required this.overallCancelRate,
    required this.overallAverageOrderValue,
    required this.data,
  });

  StatsResponse.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String,
        overallTotalRevenue = THelperFunction.formatDouble(json['overall_total_revenue']),
        overallTotalOrders = json['overall_total_orders'] as int,
        overallTotalCancelled = json['overall_total_cancelled'] as int,
        overallCancelRate = THelperFunction.formatDouble(json['overall_cancel_rate']),
        overallAverageOrderValue = THelperFunction.formatDouble(json['overall_average_order_value']),
        data = (json['data'] as List<dynamic>)
            .map((e) => StatEntry.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson({bool patch = false}) {
    final map = {
      'type': type,
      'overall_total_revenue': overallTotalRevenue,
      'overall_total_orders': overallTotalOrders,
      'overall_total_cancelled': overallTotalCancelled,
      'overall_cancel_rate': overallCancelRate,
      'overall_average_order_value': overallAverageOrderValue,
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
  final double totalRevenue;
  final int cancelledOrders;
  final double cancelRate;
  final double averageOrderValue;

  StatEntry({
    this.day,
    this.month,
    this.timeRange,
    required this.totalOrders,
    required this.totalRevenue,
    required this.cancelledOrders,
    required this.cancelRate,
    required this.averageOrderValue,
  });

  StatEntry.fromJson(Map<String, dynamic> json)
      : day = json['day'] as String?,
        month = json['month'] as String?,
        timeRange = json['time_range'] as String?,
        totalOrders = json['total_orders'] as int,
        totalRevenue = THelperFunction.formatDouble(json['total_revenue']),
        cancelledOrders = json['cancelled_orders'],
        cancelRate = THelperFunction.formatDouble(json['cancel_rate']),
        averageOrderValue = THelperFunction.formatDouble(json['average_order_value']);

  Map<String, dynamic> toJson({bool patch = false}) {
    final map = <String, dynamic>{
      'day': day,
      'month': month,
      'time_range': timeRange,
      'total_orders': totalOrders,
      'total_revenue': totalRevenue,
      'cancelled_orders': cancelledOrders,
      'cancel_rate': cancelRate,
      'average_order_value': averageOrderValue,
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