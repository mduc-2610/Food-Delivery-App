import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class BoxSkeleton extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const BoxSkeleton({
    required this.height,
    required this.width,
    this.borderRadius = TSize.borderRadiusLg,
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