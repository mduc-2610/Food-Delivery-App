import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class MainButton extends StatelessWidget {
  final double? width;
  final VoidCallback onPressed;
  final String text;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final bool isElevatedButton;
  final String? prefixIconStr;
  final String? suffixIconStr;
  final double? paddingHorizontal;
  final double? paddingVertical;

  const MainButton({
    this.width,
    required this.onPressed,
    required this.text,
    this.suffixIcon,
    this.suffixIconColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.prefixIconStr,
    this.suffixIconStr,
    this.isElevatedButton = true,
    this.paddingHorizontal,
    this.paddingVertical,
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
      ),
      child: Container(
        // height: 55,
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
        // height: 55,
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

  Row _buildButtonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null || prefixIconStr != null) ...[
          (prefixIcon != null)
            ? Icon(prefixIcon, color: prefixIconColor)
            : SvgPicture.asset(
              prefixIconStr!
            ),
          const SizedBox(width: 5),
        ],
        Text(text),
        if (suffixIcon != null || suffixIconStr != null) ...[
          const SizedBox(width: 5),
          (suffixIcon != null)
              ? Icon(suffixIcon, color: suffixIconColor)
              : SvgPicture.asset(
              suffixIconStr!
          ),
        ],
      ],
    );
  }
}
