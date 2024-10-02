import "package:flutter/material.dart";
import "package:food_delivery_app/common/controllers/bars/menu_bar_controller.dart";
import "package:food_delivery_app/common/widgets/bars/menu_bar.dart";
import "package:food_delivery_app/common/widgets/cards/circle_icon_card.dart";
import "package:food_delivery_app/features/deliverer/delivery/views/delivery/delivery.dart";
import "package:food_delivery_app/features/notification/views/notification.dart";
import "package:food_delivery_app/features/deliverer/home/views/home/home.dart";
import "package:food_delivery_app/features/restaurant/personal/views/profile/profile.dart";
import "package:food_delivery_app/features/personal/views/profile/profile.dart";
import "package:food_delivery_app/utils/constants/enums.dart";
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
    List<Widget> viewList = [
      HomeView(),
      DeliveryView(),
      NotificationView(),
      PersonalProfileView(viewType: ViewType.deliverer,),
    ];
    final MenuBarController controller = Get.put(MenuBarController(ls: viewList), tag: "Deliverer");
    return CMenuBar(
      iconList: [
        {
          "icon": TIcon.home,
          "label": "",

        },
        {
          "custom": CircleIconCard(
            icon: TIcon.delivery,
            iconSize: TSize.iconXl,
            elevation: 0,
            onTap: () {
              Get.to(() => DeliveryView());
            },
            backgroundColor: Colors.transparent,
          ),
          "label": "",
        },
        {
          "icon": TIcon.notification,
          "label": "",

        },
        {
          "icon": TIcon.person,
          "label": "",
        },
      ],
      viewList: viewList,
      tag: "deliverer",
    );
  }
}
