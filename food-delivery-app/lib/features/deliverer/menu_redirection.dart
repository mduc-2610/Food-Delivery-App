import "package:flutter/material.dart";
import "package:food_delivery_app/common/widgets/bars/menu_bar.dart";
import "package:food_delivery_app/common/widgets/cards/circle_icon_card.dart";
import "package:food_delivery_app/features/deliverer/delivery/views/delivery/delivery.dart";
import "package:food_delivery_app/features/notification/views/notification.dart";
import "package:food_delivery_app/features/restaurant/home/views/home/home.dart";
import "package:food_delivery_app/features/restaurant/personal/views/profile/profile.dart";
import "package:food_delivery_app/utils/constants/icon_strings.dart";
import "package:food_delivery_app/utils/constants/sizes.dart";
import "package:get/get.dart";

class DelivererMenuRedirection extends StatefulWidget {
  const DelivererMenuRedirection({super.key});

  @override
  State<DelivererMenuRedirection> createState() => _DelivererMenuRedirectionState();
}

class _DelivererMenuRedirectionState extends State<DelivererMenuRedirection> {
  @override
  Widget build(BuildContext context) {
    return CMenuBar(
      iconList: [
        {
          "icon": TIcon.home,
          "label": "",

        },
        // {
        //   "icon": TIcon.list,
        //   "label": "",
        // } ,
        {
          "custom": CircleIconCard(
            icon: TIcon.delivery,
            iconSize: TSize.iconXl,
            onTap: () {
              Get.to(() => DeliveryScreen());
            },
            backgroundColor: Colors.transparent,
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
        // HistoryScreen(),
        DeliveryScreen(),
        NotificationView(),
        ProfileView(),
      ],
    );
  }
}
