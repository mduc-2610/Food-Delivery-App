import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:food_delivery_app/features/restaurant/home/controllers/revenue_detail/revenue_detail_controller.dart';
import 'package:food_delivery_app/features/restaurant/home/views/revenue_detail/skeleton/revenue_history_skeleton.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/restaurant/home/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/restaurant/home/views/common/widgets/revenue_stats.dart';
import 'package:food_delivery_app/features/restaurant/home/views/revenue_detail/widgets/revenue_history.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';

class RevenueDetailView extends StatelessWidget {
  const RevenueDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RevenueDetailController());
    return Scaffold(
      appBar: CAppBar(
        title: 'Revenue Details',
        bottom: TabBar(
          controller: controller.tabController,
          tabs: [
            Tab(text: 'Statistics'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          MainWrapper(
            child: RevenueStats(
              detail: true,
              controller: RestaurantHomeController.instance,
            )
          ),
          Obx(() =>
          (controller.isLoadingHistory.value)
            ? RevenueHistorySkeleton()
            : RevenueHistory(deliveries: controller.deliveries.value,)
          )
        ],
      ),
    );
  }
}
