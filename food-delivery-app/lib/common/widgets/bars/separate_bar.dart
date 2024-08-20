import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/list/food_list.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';


class SeparateBar extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final double? radius;
  final Direction direction;
  final bool space;

  const SeparateBar({
    this.width,
    this.height,
    this.color,
    this.radius,
    this.direction = Direction.vertical,
    this.space = false,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: (space) ? (direction == Direction.horizontal) ? TSize.spaceBetweenItemsSm : 0 : 0,
        horizontal: (space) ? (direction == Direction.vertical) ? TSize.spaceBetweenItemsSm : 0 : 0,
      ),
      width: width ?? ((direction == Direction.horizontal) ? double.infinity : 1),
      height: height ?? ((direction == Direction.horizontal) ? 1 : 15),
      decoration: BoxDecoration(
        color: color ?? ((direction == Direction.horizontal) ? TColor.borderPrimary : TColor.borderSecondary),
        borderRadius: BorderRadius.circular(radius ?? 10),
      ),
    );
  }
}