import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/deliverer/home/views/home/widgets/delivery_card.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class RevenueHistorySkeleton extends StatelessWidget {
  const RevenueHistorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainWrapper(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              _buildSkeletonOrderHistoryHeader(),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              Column(
                children: List.generate(5, (index) => Column(
                  children: [
                    DeliveryCardSkeleton(),
                    SizedBox(height: TSize.spaceBetweenItemsVertical),
                  ],
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonOrderHistoryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BoxSkeleton(width: 120, height: 20),
        BoxSkeleton(width: 150, height: 40),
      ],
    );
  }

}