import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class MainWrapper extends StatelessWidget {
  final Widget child;
  final double? leftMargin;
  final double? topMargin;
  final double? rightMargin;
  final double? bottomMargin;
  final bool noMargin;

  const MainWrapper({
    Key? key,
    required this.child,
    this.leftMargin,
    this.topMargin,
    this.rightMargin,
    this.bottomMargin,
    this.noMargin = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (!noMargin) ?  EdgeInsets.fromLTRB(
          leftMargin ?? TDeviceUtil.getScreenWidth() * 0.03,
          topMargin ?? 0,
          rightMargin ?? TDeviceUtil.getScreenWidth() * 0.03,
          bottomMargin ?? 0
      ) : EdgeInsets.zero,
      child: child,
    );
  }
}

class MainWrapperSection extends StatelessWidget {
  final Widget child;
  final double? leftMargin;
  final double? topMargin;
  final double? rightMargin;
  final double? bottomMargin;
  final bool noMargin;

  const MainWrapperSection({
    Key? key,
    required this.child,
    this.leftMargin,
    this.topMargin,
    this.rightMargin,
    this.bottomMargin,
    this.noMargin = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (!noMargin) ?  EdgeInsets.fromLTRB(
          leftMargin ?? TDeviceUtil.getScreenWidth() * 0.03,
          topMargin ?? TSize.spaceBetweenItemsVertical,
          rightMargin ?? TDeviceUtil.getScreenWidth() * 0.03,
          bottomMargin ?? TSize.spaceBetweenItemsVertical,
      ) : EdgeInsets.zero,
      child: child,
    );
  }
}