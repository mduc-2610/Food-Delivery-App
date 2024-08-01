import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar_scroll_behavior.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class RestaurantDetailFlexibleAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AppBarScrollBehavior(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: Container(
                    width: TDeviceUtil.getScreenWidth(),
                    child: Image.asset(
                      TImage.hcBurger1,
                      fit: BoxFit.cover,
                    ),
                  )
              ),
            ],
          ),
        ),
        Positioned(
          top: TSize.xl,
          right: 0,
          child: MainWrapper(
            child: Row(
              children: [
                AppBarScrollBehavior(
                  child: Row(
                    children: [
                      CircleIconCard(
                        elevation: 0,
                        icon: TIcon.search,
                        backgroundColor: Colors.black.withOpacity(0.2),
                      ),
                      CircleIconCard(
                        elevation: 0,
                        iconStr: TIcon.cart,
                        backgroundColor: Colors.black.withOpacity(0.2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
