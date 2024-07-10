import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class SliverMainWrapper extends StatelessWidget {
  final Widget sliver;
  final double? leftMargin;
  final double? topMargin;
  final double? rightMargin;
  final double? bottomMargin;
  final bool noMargin;

  const SliverMainWrapper({
    Key? key,
    required this.sliver,
    this.leftMargin,
    this.topMargin,
    this.rightMargin,
    this.bottomMargin,
    this.noMargin = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: (!noMargin) ?  EdgeInsets.fromLTRB(
          leftMargin ?? TDeviceUtil.getScreenWidth() * 0.05,
          topMargin ?? 0,
          rightMargin ?? TDeviceUtil.getScreenWidth() * 0.05,
          bottomMargin ?? 0
      ) : EdgeInsets.zero,
      sliver: sliver,
    );
  }
}