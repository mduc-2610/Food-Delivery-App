import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class FoodDetailSliverAppBarSkeleton extends StatelessWidget {
  const FoodDetailSliverAppBarSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      title: BoxSkeleton(
        height: 30,
        width: 150,
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            BoxSkeleton(
              height: 270,
              width: TDeviceUtil.getScreenWidth(),
            ),
            Positioned(
              bottom: 12,
              right: 16,
              child: BoxSkeleton(
                height: 40,
                width: 40,
                borderRadius: 20,
              ),
            ),
            Positioned(
              top: TSize.xl,
              right: 16,
              child: BoxSkeleton(
                height: 40,
                width: 40,
                borderRadius: 20,
              ),
            ),
            Positioned(
              top: TSize.verticalCenterAppBar,
              right: 16,
              child: BoxSkeleton(
                height: 40,
                width: 40,
                borderRadius: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}