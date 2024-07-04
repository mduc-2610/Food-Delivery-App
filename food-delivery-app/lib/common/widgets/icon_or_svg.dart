import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class IconOrSvg extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final String? iconStr;
  final double? size;
  final double? width;
  final double? height;

  const IconOrSvg({
    this.icon,
    this.color,
    this.iconStr,
    this.size,
    this.width,
    this.height,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return (icon != null)
        ? Icon(
            icon,
            color: color,
            size: size ?? TSize.iconSm,
          )
        : SvgPicture.asset(
            iconStr!,
            width: size ?? width ?? TSize.iconSm,
            height: size ?? height ?? TSize.iconSm,
          );
  }
}
