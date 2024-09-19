import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class DottedBorder extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final Widget child;

  const DottedBorder({
    Key? key,
    this.color = TColor.secondary,
    required this.strokeWidth,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: strokeWidth, style: BorderStyle.solid, ),
        borderRadius: BorderRadius.circular(TSize.borderRadiusSm),
      ),
      child: child,
    );
  }
}