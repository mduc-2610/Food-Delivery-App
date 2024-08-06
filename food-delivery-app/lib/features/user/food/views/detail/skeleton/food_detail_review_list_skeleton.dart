import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class FoodDetailReviewListSkeleton extends StatelessWidget {
  final int itemCount;

  const FoodDetailReviewListSkeleton({
    Key? key,
    this.itemCount = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BoxSkeleton(
                      height: 40,
                      width: 40,
                      borderRadius: 20,
                    ),
                    SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BoxSkeleton(height: 14, width: 80),
                        SizedBox(height: 4),
                        BoxSkeleton(height: 12, width: 60),
                      ],
                    )
                  ],
                ),
                BoxSkeleton(height: 20, width: 100),
              ],
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoxSkeleton(height: 14, width: double.infinity),
                SizedBox(height: 4),
                BoxSkeleton(height: 14, width: double.infinity),
                SizedBox(height: 4),
                BoxSkeleton(height: 14, width: 200),
              ],
            ),
            SizedBox(height: TSize.spaceBetweenSections),
          ],
        );
      },
    );
  }
}