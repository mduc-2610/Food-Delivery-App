import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';

class ProfileDetailSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          // Skeleton for Profile Picture
          SkeletonBox(height: 100, width: 100, borderRadius: 50),
          SizedBox(height: TSize.spaceBetweenSections),

          // Skeleton for Phone Number Input
          SkeletonBox(height: 60, width: double.infinity, borderRadius: 10),
          SizedBox(height: TSize.spaceBetweenInputFields),

          // Skeleton for Email Input
          SkeletonBox(height: 60, width: double.infinity, borderRadius: 10),
          SizedBox(height: TSize.spaceBetweenInputFields),

          // Skeleton for Name Input
          SkeletonBox(height: 60, width: double.infinity, borderRadius: 10),
          SizedBox(height: TSize.spaceBetweenInputFields),

          // Skeleton for Date Picker
          SkeletonBox(height: 60, width: double.infinity, borderRadius: 10),
          SizedBox(height: TSize.spaceBetweenInputFields),

          // Skeleton for Gender Dropdown
          SkeletonBox(height: 60, width: double.infinity, borderRadius: 10),
          SizedBox(height: TSize.spaceBetweenSections),

          // Skeleton for Buttons
          SkeletonBox(height: 50, width: double.infinity, borderRadius: 10),
          SizedBox(height: TSize.spaceBetweenItemsVertical),
        ],
      ),
    );
  }
}

class SkeletonBox extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const SkeletonBox({
    required this.height,
    required this.width,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
