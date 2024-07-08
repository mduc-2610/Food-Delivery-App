import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/menu_bar_controller.dart';
import 'package:food_delivery_app/features/food/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/food/views/home/home.dart';
import 'package:food_delivery_app/features/food/views/like/food_like.dart';
import 'package:food_delivery_app/features/notification/views/notification/notification.dart';
import 'package:food_delivery_app/features/order/views/basket/order_basket.dart';
import 'package:food_delivery_app/features/order/views/history/order_history.dart';
import 'package:food_delivery_app/features/personal/views/profile/personal_profile.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';

class CMenuBar extends StatelessWidget {
  final int index;

  CMenuBar({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final MenuBarController _controller = MenuBarController.instance;
    final HomeController _homeController = Get.put(HomeController());

    return SizedBox(
      height: TDeviceUtil.getBottomNavigationBarHeight() * 1.5,
      child: BottomNavigationBar(
        iconSize: TSize.iconXl,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.off(() => HomeView());
              },
              child: Icon(TIcon.home)
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: () {
                  Get.off(() => OrderHistoryView());
                },
                child: Icon(TIcon.list)
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: () {
                  _homeController.getToFoodCategory("Liked", getOff: true);
                  // Get.off(() => FoodLikeView());
                },
                child: Icon(TIcon.favorite)
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: () {
                  Get.off(() => NotificationView());
                },
                child: Icon(TIcon.notification)
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.off(() => PersonalProfileView());
              },
              child: Icon(TIcon.person)
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: index,
        selectedItemColor: TColor.primary,
        unselectedItemColor: TColor.disable,
        onTap: _controller.updateIndex,
      ),
    );
  }
}
