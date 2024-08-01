import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/icon_or_svg.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';


class RoundIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  const RoundIconButton({
    this.icon,
    this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Container(
        padding: EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          color: TColor.primary,
          borderRadius: BorderRadius.circular(TSize.borderRadiusSm),
        ),
        child: Icon(
          icon ?? TIcon.add,
          color: TColor.light,
        )
      ),
    );
  }
}
