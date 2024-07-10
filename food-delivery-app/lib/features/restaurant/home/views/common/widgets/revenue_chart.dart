import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/head_with_action.dart';
import 'package:food_delivery_app/features/restaurant/home/views/home/widgets/filter_date.dart';
import 'package:food_delivery_app/features/restaurant/home/views/revenue_detail/revenue_detail.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:get/get.dart';


class RevenueChart extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadWithAction(
          head: RevenueTimeFilter(),
          actionText: "See detail",
          onActionTap: () {
            Get.to(() => RevenueDetailView());
          },
        ),Container(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: 6,
              minY: 0,
              maxY: 6,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 3),
                    FlSpot(1, 1),
                    FlSpot(2, 4),
                    FlSpot(3, 2),
                    FlSpot(4, 4),
                    FlSpot(5, 3),
                    FlSpot(6, 4),
                  ],
                  isCurved: true,
                  barWidth: 3,
                  color: TColor.primary,
                  belowBarData: BarAreaData(
                      show: true,
                      color: TColor.primary.withOpacity(0.2)
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

