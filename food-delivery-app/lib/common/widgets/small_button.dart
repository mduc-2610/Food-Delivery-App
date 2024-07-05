import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class SmallButton extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback onPressed;
  final String text;
  final Color? textColor;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final bool isElevatedButton;
  final String? prefixIconStr;
  final String? suffixIconStr;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final Color? backgroundColor;
  final Color? borderColor;

  const SmallButton({
    this.width,
    this.height,
    required this.onPressed,
    required this.text,
    this.textColor,
    this.suffixIcon,
    this.suffixIconColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixIconStr,
    this.suffixIconStr,
    this.isElevatedButton = true,
    this.paddingHorizontal,
    this.paddingVertical,
    this.backgroundColor,
    this.borderColor,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical ?? 0,
          horizontal: paddingHorizontal ?? TSize.md
        ),
        backgroundColor: backgroundColor,
      ),
      child: Container(
          height: height,
          padding: EdgeInsets.symmetric(
              vertical: paddingVertical ?? 0,
              horizontal: paddingHorizontal ?? 0
          ),
          // width: width,
          // width: width ?? TDeviceUtil.getScreenWidth() * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
          ),
          child: _buildButtonContent(context)
      ),
    );
  }

  Center _buildButtonContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixIcon != null || prefixIconStr != null) ...[
                (prefixIcon != null)
                    ? Icon(prefixIcon, color: prefixIconColor)
                    : SvgPicture.asset(
                    prefixIconStr!,
                  width: TSize.md,
                  height: TSize.md,
                ),
                SizedBox(width: TSize.sm,),
              ],
              Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(color: TColor.light)
              ),
              if (suffixIcon != null || suffixIconStr != null) ...[
                SizedBox(width: TSize.sm,),
                (suffixIcon != null)
                    ? Icon(suffixIcon, color: suffixIconColor)
                    : SvgPicture.asset(
                    suffixIconStr!,
                  width: TSize.md,
                  height: TSize.md,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
