import 'package:flutter/material.dart';
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

  const MainButton({
    this.width,
    required this.onPressed,
    required this.text,
    this.suffixIcon,
    this.suffixIconColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.isElevatedButton = true,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      // width: width ?? TDeviceUtil.getScreenWidth() * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
      ),
      child: isElevatedButton
          ? ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: _buildButtonContent(),
      )
          : TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  Row _buildButtonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          Icon(prefixIcon, color: prefixIconColor),
          const SizedBox(width: 5),
        ],
        Text(text),
        if (suffixIcon != null) ...[
          const SizedBox(width: 5),
          Icon(suffixIcon, color: suffixIconColor),
        ],
      ],
    );
  }
}
