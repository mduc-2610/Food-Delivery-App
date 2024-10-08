import "package:flutter/material.dart";
import "package:food_delivery_app/common/widgets/bars/menu_bar.dart";
import "package:food_delivery_app/common/widgets/cards/circle_icon_card.dart";
import "package:food_delivery_app/features/notification/views/notification.dart";
import "package:food_delivery_app/features/personal/views/profile/profile.dart";
import "package:food_delivery_app/features/restaurant/food/views/add/restaurant_add.dart";
import "package:food_delivery_app/features/restaurant/food/views/add/widgets/food_add.dart";
import "package:food_delivery_app/features/restaurant/food/views/manage/food_manage.dart";
import "package:food_delivery_app/features/restaurant/home/views/home/home.dart";
import "package:food_delivery_app/features/restaurant/personal/views/profile/profile.dart";
import "package:food_delivery_app/utils/constants/colors.dart";
import "package:food_delivery_app/utils/constants/enums.dart";
import "package:food_delivery_app/utils/constants/icon_strings.dart";
import "package:food_delivery_app/utils/constants/sizes.dart";
import "package:get/get.dart";

class RestaurantMenuRedirection extends StatefulWidget {
  const RestaurantMenuRedirection({super.key});

  @override
  State<RestaurantMenuRedirection> createState() => _RestaurantMenuRedirectionState();
}

class _RestaurantMenuRedirectionState extends State<RestaurantMenuRedirection> {
  @override
  Widget build(BuildContext context) {
    return CMenuBar(
      tag: "restaurant",
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
            onTap: () {
              Get.to(() => RestaurantAddView());
            },
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
        HomeView(),
        FoodManageView(),
        RestaurantAddView(),
        NotificationView(),
        PersonalProfileView(viewType: ViewType.restaurant,),
      ],
    );
  }
}
