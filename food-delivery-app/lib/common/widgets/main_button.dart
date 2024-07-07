import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class MainButton extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback? onPressed;
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
  final TextStyle? textStyle;

  const MainButton({
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
    this.textStyle = const TextStyle(),
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return isElevatedButton
        ? ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        // padding: EdgeInsets.symmetric(
        //     // vertical: paddingVertical ?? 0,
        //     // horizontal: paddingHorizontal ?? 0
        // ),
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
          child: _buildButtonContent()
      ),
    )
        : TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
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
          child: _buildButtonContent()),
    );
  }

  Center _buildButtonContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixIcon != null || prefixIconStr != null) ...[
                (prefixIcon != null)
                  ? Icon(prefixIcon, color: prefixIconColor)
                  : SvgPicture.asset(
                    prefixIconStr!
                  ),
                SizedBox(width: TSize.spaceBetweenItemsHorizontal),
              ],
              Text(
                text,
                style: textStyle?.copyWith(color: textColor)
              ),
              if (suffixIcon != null || suffixIconStr != null) ...[
                SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                (suffixIcon != null)
                    ? Icon(suffixIcon, color: suffixIconColor)
                    : SvgPicture.asset(
                    suffixIconStr!
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
