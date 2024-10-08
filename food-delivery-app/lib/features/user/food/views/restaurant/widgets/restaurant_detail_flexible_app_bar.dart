import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar_scroll_behavior.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class RestaurantDetailFlexibleAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = RestaurantDetailController.instance;
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
                  child: THelperFunction.getValidImage(
                      controller.restaurant?.detailInfo?.coverImage
                  ),
                ),
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