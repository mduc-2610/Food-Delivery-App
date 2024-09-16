import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class HomeSliverAppBarSkeleton extends StatelessWidget {
  const HomeSliverAppBarSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: TDeviceUtil.getAppBarHeight(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          BoxSkeleton(
            height: 12,
            width: 80,
          ),
          SizedBox(height: 5),

          Row(
            children: [
              BoxSkeleton(
                height: 16,
                width: TDeviceUtil.getScreenWidth() * 0.7,
              ),
            ],
          ),
        ],
      ),
      expandedHeight: TDeviceUtil.getAppBarHeight(),
      flexibleSpace: Stack(
        children: [
          Positioned(
            top: TDeviceUtil.getAppBarHeight() / 2 + 12,
            right: 16,
            child: BoxSkeleton(
              height: TSize.iconLg,
              width: TSize.iconLg,
              borderRadius: TSize.borderRadiusCircle,
            ),
          ),
        ],
      ),
    );
  }
}
