import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/head_with_action.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/misc/sliver_main_wrapper.dart';
import 'package:food_delivery_app/features/restaurant/home/views/home/widgets/home_sliver_app_bar.dart';
import 'package:food_delivery_app/features/restaurant/home/views/home/widgets/metric_card.dart';
import 'package:food_delivery_app/features/restaurant/home/views/home/widgets/process_order.dart';
import 'package:food_delivery_app/features/restaurant/home/views/common/widgets/revenue_chart.dart';
import 'package:food_delivery_app/features/restaurant/home/views/home/widgets/review_summary.dart';
import 'package:food_delivery_app/common/widgets/cards/food_card.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/emojis.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/features/restaurant/home/views/revenue_detail/widgets/revenue_history.dart';
import 'package:food_delivery_app/features/restaurant/home/views/revenue_detail/widgets/revenue_statistics.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CAppBar(
          title: "Hello, Duc ${TEmoji.smilingFaceWithHeart}",
          noLeading: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Statistics'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RunningOrder(),
            RevenueHistory(orders: THardCode.getOrderList(),)
          ],
        ),
      ),
    );
  }
}



class RunningOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: MainWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: TSize.spaceBetweenSections),
              RevenueChart(),
              SizedBox(height: TSize.spaceBetweenSections),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(TSize.md),
                  child: _buildCurrentDeliveries()
                ),
              ),
              SizedBox(height: TSize.spaceBetweenSections),
              Card(
                elevation: TSize.cardElevation,
                child: Padding(
                  padding: EdgeInsets.all(TSize.md),
                  child: ReviewsSummary()
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentDeliveries() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Deliveries',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        _buildDeliveryItem('Order #1234', 'In Progress', Colors.orange),
        SizedBox(height: 8),
        _buildDeliveryItem('Order #5678', 'Picked Up', Colors.blue),
        SizedBox(height: 8),
        _buildDeliveryItem('Order #9012', 'En Route', Colors.green),
      ],
    );
  }

  Widget _buildDeliveryItem(String orderNumber, String status, Color statusColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(orderNumber, style: TextStyle(fontSize: 16)),
        Chip(
          label: Text(status),
          backgroundColor: statusColor,
          labelStyle: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}