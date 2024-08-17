import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/user/food/views/detail/skeleton/food_detail_bottom_app_bar_skeleton.dart';
import 'package:food_delivery_app/features/user/food/views/detail/skeleton/food_detail_sliver_app_bar_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class DetailViewSkeleton extends StatelessWidget {
  const DetailViewSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          FoodDetailSliverAppBarSkeleton(),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      BoxSkeleton(height: 30, width: 80),
                      SizedBox(width: TSize.spaceBetweenItemsVertical),
                      BoxSkeleton(height: 30, width: 80),
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),

                  Row(
                    children: [
                      BoxSkeleton(height: 20, width: 100),
                      Spacer(),
                      BoxSkeleton(height: 20, width: 100),
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),

                  BoxSkeleton(height: 60, width: double.infinity),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BoxSkeleton(height: 20, width: 60),
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),

                  BoxSkeleton(height: 30, width: 200),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),

                  for (int i = 0; i < 3; i++) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoxSkeleton(height: 20, width: 100),
                        Row(
                          children: [
                            BoxSkeleton(height: 20, width: 60),
                            SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                            BoxSkeleton(height: 24, width: 24),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: TSize.spaceBetweenItemsVertical),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FoodDetailBottomAppBarSkeleton(),
    );
  }
}