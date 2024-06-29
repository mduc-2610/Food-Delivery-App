import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class MainWrapper extends StatelessWidget {
  final Widget child;
  final double? leftMargin;
  final double? topMargin;
  final double? rightMargin;
  final double? bottomMargin;

  const MainWrapper({
    Key? key,
    required this.child,
    this.leftMargin,
    this.topMargin,
    this.rightMargin,
    this.bottomMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          leftMargin ?? TDeviceUtil.getScreenWidth() * 0.05,
          topMargin ?? 0,
          rightMargin ?? TDeviceUtil.getScreenWidth() * 0.05,
          bottomMargin ?? 0
      ),
      child: child,
    );
  }
}