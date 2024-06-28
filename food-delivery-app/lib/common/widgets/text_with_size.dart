import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class TextWithSize extends StatelessWidget {
  final double aspectScreenWidth;
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  const TextWithSize({
    Key? key,
    required this.aspectScreenWidth,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: TDeviceUtil.getScreenWidth() * aspectScreenWidth ,
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap ?? true, // Default to true if not provided
      ),
    );
  }
}
