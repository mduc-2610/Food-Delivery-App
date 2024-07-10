import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/features/restaurant/home/views/revenue_detail/widgets/revenue_history.dart';
import 'package:food_delivery_app/features/restaurant/home/views/revenue_detail/widgets/revenue_statistics.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';

class RevenueDetailView extends StatelessWidget {
  const RevenueDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CAppBar(
          title: 'Revenue Details',
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Statistics'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RevenueStatistics(),
            RevenueHistory(orders: THardCode.getOrderList(),)
          ],
        ),
      ),
    );
  }
}
