import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class HomeViewSkeleton extends StatelessWidget {
  const HomeViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BoxSkeleton(height: 32, width: TDeviceUtil.getScreenWidth() * 0.7),
        centerTitle: true,
      ),
      body: MainWrapper(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoxSkeleton(height: 40, width: 100, borderRadius: TSize.borderRadiusCircle,),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              Card(
                elevation: TSize.cardElevation,
                child: Padding(
                  padding: EdgeInsets.all(TSize.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSkeletonHeadWithAction(),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      _buildSkeletonReviewSection(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              _buildSkeletonOrderHistoryHeader(),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              _buildSkeletonOrderHistoryList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonHeadWithAction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BoxSkeleton(width: 100, height: 20),
        BoxSkeleton(width: 80, height: 20),
      ],
    );
  }

  Widget _buildSkeletonReviewSection() {
    return Row(
      children: [
        BoxSkeleton(width: TSize.iconSm, height: TSize.iconSm),
        SizedBox(width: TSize.spaceBetweenItemsHorizontal),
        BoxSkeleton(width: 40, height: 20),
        SizedBox(width: TSize.spaceBetweenItemsHorizontal),
        BoxSkeleton(width: 120, height: 20),
      ],
    );
  }

  Widget _buildSkeletonOrderHistoryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BoxSkeleton(width: 150, height: 20),
        BoxSkeleton(width: 150, height: 20),
      ],
    );
  }

  Widget _buildSkeletonOrderHistoryList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          elevation: TSize.cardElevation,
          margin: EdgeInsets.only(bottom: TSize.spaceBetweenItemsVertical),
          child: Padding(
            padding: EdgeInsets.all(TSize.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoxSkeleton(width: 200, height: 20),
                SizedBox(height: TSize.spaceBetweenItemsVertical / 2),
                BoxSkeleton(width: double.infinity, height: 14),
                SizedBox(height: TSize.spaceBetweenItemsVertical / 2),
                BoxSkeleton(width: 100, height: 14),
              ],
            ),
          ),
        );
      },
    );
  }
}