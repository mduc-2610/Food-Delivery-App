import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/list/restaurant_list.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/user/food/views/home/skeleton/home_sliver_app_bar_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class HomeViewSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HomeSliverAppBarSkeleton(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                MainWrapper(
                  child: Row(
                    children: [
                      BoxSkeleton(height: 40, width: 100, borderRadius: TSize.borderRadiusCircle,),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                      BoxSkeleton(height: 40, width: 100, borderRadius: TSize.borderRadiusCircle,),
                    ],
                  ),
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                MainWrapper(
                  rightMargin: 0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        BoxSkeleton(
                          height: TDeviceUtil.getScreenHeight() * 0.15,
                          width: TDeviceUtil.getScreenWidth() * 0.6,
                        ),
                        SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                        BoxSkeleton(
                          height: TDeviceUtil.getScreenHeight() * 0.15,
                          width: TDeviceUtil.getScreenWidth() * 0.6,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: TSize.spaceBetweenSections),

                MainWrapper(
                  child: BoxSkeleton(height: 50, width: double.infinity),
                ),
                SizedBox(height: TSize.spaceBetweenSections),

                MainWrapper(
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      8,
                          (index) => BoxSkeleton(height: 80, width: 80),
                    ),
                  ),
                ),
                SizedBox(height: TSize.spaceBetweenSections),

                MainWrapper(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BoxSkeleton(height: 20, width: 120),
                          BoxSkeleton(height: 20, width: 80),
                        ],
                      ),
                      SizedBox(height: TSize.spaceBetweenSections),
                      // GridView.count(
                      //   crossAxisCount: 2,
                      //   crossAxisSpacing: 10,
                      //   mainAxisSpacing: 10,
                      //   childAspectRatio: 13 / 16,
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   children: List.generate(
                      //     4,
                      //         (index) => BoxSkeleton(height: 180, width: double.infinity),
                      //   ),
                      // ),
                      RestaurantListSkeleton()
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}