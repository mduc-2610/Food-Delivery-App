import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class DetailReviewViewSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                CSliverAppBar(
                  title: "Reviews",
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      MainWrapper(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BoxSkeleton(height: 50, width: 80),
                                SizedBox(height: TSize.spaceBetweenItemsHorizontal),
                                BoxSkeleton(height: 40, width: 160),
                                SizedBox(height: TSize.spaceBetweenItemsHorizontal),
                                BoxSkeleton(height: 20, width: 60),
                              ],
                            ),
                            SizedBox(
                              width: TDeviceUtil.getScreenWidth() * 0.45,
                              child: Column(
                                children: List.generate(5, (index) =>
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 4),
                                      child: BoxSkeleton(height: 10, width: double.infinity),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      MainWrapper(
                        rightMargin: 0,
                        child: BoxSkeleton(height: 40, width: double.infinity),
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      MainWrapper(
                        child: FoodReviewListSkeleton()
                      ),
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

class FoodReviewListSkeleton extends StatelessWidget {
  final int length;
  const FoodReviewListSkeleton({
    this.length = 7,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(length, (index) =>
            Column(
              children: [
                MainWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              BoxSkeleton(height: 40, width: 40, borderRadius: 20),
                              SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BoxSkeleton(height: 16, width: 80),
                                  SizedBox(height: 4),
                                  BoxSkeleton(height: 14, width: 60),
                                ],
                              ),
                            ],
                          ),
                          BoxSkeleton(height: 20, width: 100),
                        ],
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      BoxSkeleton(height: 14, width: double.infinity),
                      SizedBox(height: 4),
                      BoxSkeleton(height: 14, width: double.infinity),
                      SizedBox(height: 4),
                      BoxSkeleton(height: 14, width: 200),
                      SizedBox(height: TSize.spaceBetweenSections),

                    ],
                  ),
                ),
                SeparateSectionBar()

              ],
            )
        ),
      ),
    );
  }
}
