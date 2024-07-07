import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';


class HomeSliverAppBar extends StatelessWidget {

  const HomeSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: TDeviceUtil.getAppBarHeight(),
      // backgroundColor: Theme,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver to",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 5,),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "Select your location  ",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                ),
                Icon(TIcon.arrowFoward, size: TSize.iconSm, color: TColor.primary,),
              ],
            ),
          ),
        ],
      ),
      expandedHeight: TDeviceUtil.getAppBarHeight(),
      flexibleSpace: Stack(
        children: [
          Positioned(
            top: TDeviceUtil.getAppBarHeight() / 2 + 12,
            right: 16,
            child: CircleIconCard(
              elevation: TSize.iconCardElevation,
              iconStr: TIcon.cart,
            ),
          ),
        ],
      ),
    );
  }
}

