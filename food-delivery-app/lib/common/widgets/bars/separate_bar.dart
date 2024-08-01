import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';

class SeparateBar extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final double? radius;
  const SeparateBar({
    this.width,
    this.height,
    this.color,
    this.radius,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 1,
      height: height ?? 15,
      decoration: BoxDecoration(
        color: color ?? TColor.borderSecondary,
        borderRadius: BorderRadius.circular(radius ?? 10),
      ),
    );
  }
}