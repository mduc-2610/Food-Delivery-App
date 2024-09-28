// In RevenueChart.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/restaurant/home/models/stats.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/restaurant/home/controllers/home/home_controller.dart';
import 'package:food_delivery_app/common/widgets/misc/head_with_action.dart';
import 'package:food_delivery_app/features/restaurant/home/views/home/widgets/filter_date.dart';
import 'package:food_delivery_app/features/restaurant/home/views/revenue_detail/revenue_detail.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RevenueChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RestaurantHomeController controller = Get.find<RestaurantHomeController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.statsResponse == null || controller.statsResponse!.data.isEmpty) {
        return Column(
          children: [
            HeadWithAction(
              head: RevenueTimeFilter(),
              actionText: "See detail",
              onActionTap: () {
                Get.to(() => RevenueDetailView());
              },
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            Center(
              child: Text(
                "No revenue data available.",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      }

      List<String> labels = [];
      int dataLength = controller.statsResponse!.data.length;

      switch (controller.timeRange.value) {
        case TimeRange.yearly:
          labels = _getMonthlyLabels();
          break;
        case TimeRange.monthly:
          labels = _getDailyLabels();
          break;
        case TimeRange.daily:
          labels = _getHourlyLabels();
          break;
      }

      List<FlSpot> spots = controller.statsResponse!.data.asMap().entries.map((entry) {
        int index = entry.key;
        StatEntry stat = entry.value;
        return FlSpot(index.toDouble(), stat.totalSales);
      }).toList();

      double maxX = labels.length > 0 ? (labels.length - 1).toDouble() : 6;
      double maxY = spots.isNotEmpty
          ? spots.map((e) => e.y).reduce((a, b) => a > b ? a : b)
          : 6;

      return Column(
        children: [
          HeadWithAction(
            head: RevenueTimeFilter(),
            actionText: "See detail",
            onActionTap: () {
              Get.to(() => RevenueDetailView());
            },
          ),
          SizedBox(height: TSize.spaceBetweenItemsVertical),
          Container(
            height: 200,
            padding: EdgeInsets.symmetric(horizontal: TSize.md),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true, drawVerticalLine: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < labels.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              labels[index],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }
                        return Text('');
                      },
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                minX: 0,
                maxX: maxX < 6 ? 6 : maxX,
                minY: 0,
                maxY: maxY < 6 ? 6 : maxY + 10,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    barWidth: 3,
                    belowBarData: BarAreaData(
                      show: true,
                    ),
                    dotData: FlDotData(
                      show: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  List<String> _getMonthlyLabels() {
    return [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
  }

  List<String> _getDailyLabels() {
    return List<String>.generate(31, (index) => '${index + 1}');
  }

  List<String> _getHourlyLabels() {
    return List<String>.generate(24, (index) => '${index}h');
  }
}


class RevenueTimeFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RestaurantHomeController controller = Get.find<RestaurantHomeController>();

    return Obx(() {
      return Row(
        children: [
          DropdownButton<TimeRange>(
            value: controller.timeRange.value,
            onChanged: (TimeRange? newValue) {
              if (newValue != null) {
                controller.updateTimeRange(newValue);
              }
            },
            items: TimeRange.values.map((TimeRange range) {
              return DropdownMenuItem<TimeRange>(
                value: range,
                child: Text(range.toString().split('.').last.capitalizeFirst!),
              );
            }).toList(),
          ),
          SizedBox(width: 10),
          if (controller.timeRange.value == TimeRange.yearly)
            _buildYearPicker(controller)
          else if (controller.timeRange.value == TimeRange.monthly)
            _buildMonthYearPicker(controller)
          else if (controller.timeRange.value == TimeRange.daily)
              _buildDatePicker(controller),
        ],
      );
    });
  }

  Widget _buildYearPicker(RestaurantHomeController controller) {
    return DropdownButton<int>(
      value: controller.selectedYear.value,
      onChanged: (int? newValue) {
        if (newValue != null) {
          controller.updateYear(newValue);
        }
      },
      items: List<int>.generate(10, (i) => DateTime.now().year - i)
          .map((int year) {
        return DropdownMenuItem<int>(
          value: year,
          child: Text(year.toString()),
        );
      }).toList(),
    );
  }

  Widget _buildMonthYearPicker(RestaurantHomeController controller) {
    return Row(
      children: [
        DropdownButton<int>(
          value: controller.selectedMonth.value,
          onChanged: (int? newValue) {
            if (newValue != null) {
              controller.updateMonth(newValue);
            }
          },
          items: List<int>.generate(12, (i) => i + 1).map((int month) {
            return DropdownMenuItem<int>(
              value: month,
              child: Text(month.toString().padLeft(2, '0')),
            );
          }).toList(),
        ),
        SizedBox(width: 10),
        _buildYearPicker(controller),
      ],
    );
  }

  Widget _buildDatePicker(RestaurantHomeController controller) {
    return ElevatedButton(
      child: Text(controller.selectedDate.value.toString().split(' ')[0]),
      onPressed: () async {
        final DateTime? picked = await showDatePicker(
          context: Get.context!,
          initialDate: controller.selectedDate.value,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (picked != null && picked != controller.selectedDate.value) {
          controller.updateDate(picked);
        }
      },
    );
  }
}