import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class ContainerCard extends StatelessWidget {
  final Color? borderColor;
  final Color? bgColor;
  final Widget child;

  const ContainerCard({
    this.borderColor,
    this.bgColor,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: TSize.xs,
        horizontal: TSize.md,
      ),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.transparent,
        border: Border.all(
          width: 1,
          color: borderColor ?? TColor.borderPrimary,
        ),
        borderRadius: BorderRadius.circular(TSize.borderRadiusLg),
      ),
      child: child
    );
  }
}
