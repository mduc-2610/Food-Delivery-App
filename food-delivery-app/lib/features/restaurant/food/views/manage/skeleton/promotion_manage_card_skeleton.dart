import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class PromotionManageCardSkeleton extends StatelessWidget {
  final ViewType viewType;

  const PromotionManageCardSkeleton({Key? key, required this.viewType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoxSkeleton(height: 40, width: 40, borderRadius: 20),
            SizedBox(width: TSize.spaceBetweenItemsMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoxSkeleton(width: 150, height: 20),
                  SizedBox(height: TSize.spaceBetweenItemsSm),
                  BoxSkeleton(width: 200, height: 16),
                  SizedBox(height: TSize.spaceBetweenItemsMd),
                  BoxSkeleton(width: 100, height: 16),
                  SizedBox(height: TSize.spaceBetweenItemsSm),
                  BoxSkeleton(width: 180, height: 14),
                  SizedBox(height: TSize.spaceBetweenItemsSm),
                  BoxSkeleton(width: 160, height: 14),
                ],
              ),
            ),
            SizedBox(width: TSize.spaceBetweenItemsSm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                viewType == ViewType.restaurant
                    ? BoxSkeleton(height: 30, width: 30, borderRadius: 15)
                    : BoxSkeleton(height: 24, width: 24, borderRadius: 12),
                SizedBox(height: TSize.spaceBetweenItemsMd),
                BoxSkeleton(width: 60, height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}