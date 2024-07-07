import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar_scroll_behavior.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';


class FoodDetailFlexibleAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBarScrollBehavior(
          child: getImage(TImage.hcBurger1),
        ),
        Positioned(
          bottom: 12,
          right: 0,
          child: MainWrapper(
            child: Row(
              children: [
                AppBarScrollBehavior(
                  child: CircleIconCard(
                    iconSize: TSize.iconSm,
                    iconStr: TIcon.heart,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: TSize.xl,
          right: 0,
          child: MainWrapper(
            child: Row(
              children: [
                AppBarScrollBehavior(
                  child: CircleIconCard(
                    iconStr: TIcon.cart,
                  ),
                ),
              ],
            ),
          ),
        ),
        MainWrapper(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppBarScrollBehavior(
                isScrollHidden: false,
                child: Container(
                  margin: EdgeInsets.only(top: TSize.verticalCenterAppBar),
                  child: CircleIconCard(
                    elevation: TSize.iconCardElevation,
                    iconStr: TIcon.cart,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getImage(String image) {
    return Container(
      width: TDeviceUtil.getScreenWidth(),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }

}