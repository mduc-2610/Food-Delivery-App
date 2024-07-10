import "package:flutter/material.dart";
import "package:food_delivery_app/common/widgets/bars/menu_bar.dart";
import "package:food_delivery_app/common/widgets/cards/circle_icon_card.dart";
import "package:food_delivery_app/features/restaurant/personal/views/profile/profile.dart";
import "package:food_delivery_app/features/restaurant/food/views/food_list.dart";
import 'package:food_delivery_app/features/restaurant/home/views/home/home.dart';
import "package:food_delivery_app/features/restaurant/notifications/views/notification.dart";
import "package:food_delivery_app/utils/constants/colors.dart";
import "package:food_delivery_app/utils/constants/icon_strings.dart";
import "package:food_delivery_app/utils/constants/sizes.dart";

class RestaurantMenuRedirection extends StatelessWidget {
  const RestaurantMenuRedirection({super.key});

  @override
  Widget build(BuildContext context) {
    return CMenuBar(
      iconList: [
        {
          "icon": TIcon.home,
          "label": "",

        },
        {
          "icon": TIcon.list,
          "label": "",
        } ,
        {
          "custom": CircleIconCard(
            icon: TIcon.add,
            iconSize: TSize.iconMd,
            iconColor: TColor.primary,
            backgroundColor: Color(0xFFfff1f2),
            borderSideColor: TColor.primary,
            borderSideWidth: 1.5,
          ),
          "label": "",
        },
        {
          "icon": TIcon.notification,
          "label": "",

        },{
          "icon": TIcon.person,
          "label": "",
        },
      ],
      viewList: [
        DashboardHome(),
        FoodApp(),
        FoodApp(),
        RestaurantNotification(),
        ProfileView(),
      ],
    );
  }
}
