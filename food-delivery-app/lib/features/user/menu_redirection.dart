import "package:flutter/material.dart";
import "package:food_delivery_app/common/controllers/menu_bar_controller.dart";
import "package:food_delivery_app/common/widgets/bars/menu_bar.dart";
import "package:food_delivery_app/features/notification/views/notification.dart";
import "package:food_delivery_app/features/user/food/views/home/home.dart";
import "package:food_delivery_app/features/user/food/views/like/food_like.dart";
import "package:food_delivery_app/features/user/order/views/history/order_history.dart";
import "package:food_delivery_app/features/user/personal/views/profile/profile.dart";
import "package:food_delivery_app/utils/constants/icon_strings.dart";
import 'package:get/get.dart';

class UserMenuRedirection extends StatelessWidget {
  const UserMenuRedirection({super.key});

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
          "icon": TIcon.favorite,
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
        HomeView(),
        OrderHistoryView(),
        FoodLikeView(),
        NotificationView(),
        PersonalProfileView(),
      ],
    );
  }
}
