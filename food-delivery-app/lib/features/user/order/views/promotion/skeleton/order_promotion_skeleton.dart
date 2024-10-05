import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/bottom_bar_wrapper.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/restaurant/food/views/manage/skeleton/promotion_manage_card_skeleton.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class OrderPromotionSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
          slivers: [
            CSliverAppBar(
              title: "Promotions",
            ),
            SliverToBoxAdapter(
              child: MainWrapper(
                topMargin: TSize.spaceBetweenItemsVertical,
                child: Column(
                  children: [
                    BoxSkeleton(height: 50, width: double.infinity),
                    SizedBox(height: TSize.spaceBetweenSections),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                MainWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoxSkeleton(height: 24, width: 150),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      PromotionManageCardSkeleton(viewType: ViewType.user),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      PromotionManageCardSkeleton(viewType: ViewType.user),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      Center(child: BoxSkeleton(height: 20, width: 70)),

                      SizedBox(height: TSize.spaceBetweenSections),
                      BoxSkeleton(height: 24, width: 150),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      PromotionManageCardSkeleton(viewType: ViewType.user),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      PromotionManageCardSkeleton(viewType: ViewType.user),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      Center(child: BoxSkeleton(height: 20, width: 70)),

                      // SizedBox(height: TSize.spaceBetweenItemsVertical),
                      // BoxSkeleton(height: 60, width: double.infinity),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                    ],
                  ),
                ),
              ]),
            ),
          ]
      ),
      bottomNavigationBar: BottomBarWrapper(
        // bottomMargin: TSize.spaceBetweenSections,
        child: MainWrapper(
          child: Container(
            height: TDeviceUtil.getBottomNavigationBarHeight(),
            child: BoxSkeleton(height: 50, width: double.infinity, borderRadius: TSize.borderRadiusCircle,),
          ),
        ),
      ),
    );
  }
}