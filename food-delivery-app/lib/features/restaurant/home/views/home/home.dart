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
import 'package:food_delivery_app/common/widgets/cards/food_card_gr.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
          slivers: [
            HomeSliverAppBar(),

            SliverToBoxAdapter(
              child: MainWrapper(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: InkWell(
                            onTap: () {
                              showProcessOrder(context, THardCode.getOrderList(), "Running Orders");
                            },
                            child: MetricCard(value: 20, label: 'RUNNING ORDERS')
                        )
                        ),
                        SizedBox(width: TSize.spaceBetweenItemsVertical,),
                        Expanded(child: InkWell(
                            onTap: () {
                              showProcessOrder(context, THardCode.getOrderList(), "Order Requests");
                            },
                            child: MetricCard(value: 05, label: 'ORDER REQUEST')
                        )
                        ),
                      ],
                    ),
                    SizedBox(height: TSize.spaceBetweenSections,),

                    RevenueChart(),
                    SizedBox(height: TSize.spaceBetweenItemsVertical,),

                    ReviewsSummary(),
                    SizedBox(height: TSize.spaceBetweenItemsVertical,),

                    HeadWithAction(
                      title: "Popular items this week",
                      actionText: "See all",
                      onActionTap: () {

                      },
                    ),

                    SizedBox(height: TSize.spaceBetweenItemsVertical,),
                  ],
                ),
              ),
            ),

            SliverMainWrapper(
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: TSize.gridViewSpacing,
                  mainAxisSpacing: TSize.gridViewSpacing,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: 8,
                  (context, index) => FoodCard(
                    type: FoodCardType.grid,
                    name: 'Pizza',
                    image: 'assets/images/pizza.png',
                    stars: 4.5,
                    originalPrice: 10.0,
                    salePrice: 7.5,
                    onTap: () {},
                    heart: 'assets/icons/heart.svg',
                  ),
                ),
              ),
            )
          ]
      ),
    );
  }
}

