import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class SeparateSectionBar extends StatelessWidget {
  final Color? color;
  final double? height;
  const SeparateSectionBar({
    this.color,
    this.height,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? TSize.spaceBetweenItemsVertical,
      color: color ?? TColor.spaceBetweenSections,
    );
  }
}
