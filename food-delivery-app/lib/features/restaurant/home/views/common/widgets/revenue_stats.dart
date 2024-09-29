// In RevenueChart.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/restaurant/home/models/stats.dart';
import 'package:food_delivery_app/features/restaurant/home/views/common/widgets/revenue_time_filter.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/restaurant/home/controllers/home/home_controller.dart';
import 'package:food_delivery_app/common/widgets/misc/head_with_action.dart';
import 'package:food_delivery_app/features/restaurant/home/views/revenue_detail/revenue_detail.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';

class RevenueStats extends StatelessWidget {
  final bool detail;
  final RestaurantHomeController controller;

  const RevenueStats({
    this.detail = false,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    $print("OVERALL: ${controller.statsResponse.value?.overallTotalRevenue}");
    // final RestaurantHomeController controller = Get.find<RestaurantHomeController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.statsResponse == null || controller.statsResponse.value!.data.isEmpty) {
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
      int dataLength = controller.statsResponse.value!.data.length;

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

      List<FlSpot> spots = controller.statsResponse.value!.data.asMap().entries.map((entry) {
        int index = entry.key;
        StatEntry stat = entry.value;
        return FlSpot(index.toDouble(), stat.totalRevenue);
      }).toList();

      double maxX = labels.length > 0 ? (labels.length - 1).toDouble() : 6;
      double maxY = spots.isNotEmpty
          ? spots.map((e) => e.y).reduce((a, b) => a > b ? a : b)
          : 6;

      return SingleChildScrollView(
        child: Column(
          children: [
            if(detail) SizedBox(height: TSize.spaceBetweenItemsVertical),
            HeadWithAction(
              head: RevenueTimeFilter(),
              actionText: (detail)? "" : "See detail",
              onActionTap: () {
                Get.to(() => RevenueDetailView());
              },
            ),
            SizedBox(height: TSize.spaceBetweenItemsHorizontal),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Total revenue: ",
                  style: Get.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: TSize.spaceBetweenItemsHorizontal),
                Text(
                  "£${controller.statsResponse.value?.overallTotalRevenue}",
                  style: Get.textTheme.headlineSmall,
                ),
              ],
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
        
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            if(detail)...[
              _buildStatisticsGrid(controller.statsResponse.value),
            ]
          ],
        ),
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

  String get boomRate {
    int totalOrders = 45;
    int boomOrders = 7;
    double rate = (boomOrders / totalOrders) * 100;
    return '${rate.toStringAsFixed(1)}%';
  }

  Widget _buildStatisticsGrid(StatsResponse? stats) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildStatsCard('Total Orders', "${stats?.overallTotalOrders.toString()}"),
        _buildStatsCard('Average Order Value', '\$${stats?.overallAverageOrderValue.toStringAsFixed(2)}'),
        // _buildStatsCard('Total Revenue', '\$${stats?.totalRevenueAll.toStringAsFixed(2)}'),
        _buildStatsCard('Canceled Orders', "${stats?.overallTotalCancelled.toString()}"),
        _buildStatsCard('Cancel Rate', '${stats?.overallCancelRate.toStringAsFixed(2)}%'),
      ],
    );
  }

  Widget _buildStatsCard(String title, String value) {
    return Card(
      elevation: TSize.cardElevationSm,
      child: Padding(
        padding: EdgeInsets.all(TSize.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Get.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: TSize.spaceBetweenItemsHorizontal),
            Text(
              "$value" ,
              style: Get.textTheme.headlineMedium?.copyWith(color: TColor.primary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

