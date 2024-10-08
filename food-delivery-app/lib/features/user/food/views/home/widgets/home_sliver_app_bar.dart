import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/features/user/food/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/user/food/views/basket/user_basket_view.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';


class HomeSliverAppBar extends StatelessWidget {

  const HomeSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController _controller = HomeController.instance;
    var addressName = _controller.user?.selectedLocation?.name ?? "Select your location";
    bool isLonger = (addressName?.length ?? 0) > 30;
    addressName = addressName?.substring(0, min(addressName.length, 30)) ?? "";
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
            onTap: _controller.getToOrderLocation,
            child: Row(
              children: [
                Text(
                  "${addressName}${isLonger ? "..." : ""}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                ),
                Icon(TIcon.arrowForward, size: TSize.iconSm, color: TColor.primary,),
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
              onTap: () {
                Get.to(() => UserBasketView());
              },
              elevation: TSize.iconCardElevation,
              iconStr: TIcon.cart,
            ),
          ),
        ],
      ),
    );
  }
}

