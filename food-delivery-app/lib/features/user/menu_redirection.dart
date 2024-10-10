import "package:flutter/material.dart";
import "package:food_delivery_app/common/controllers/bars/menu_bar_controller.dart";
import "package:food_delivery_app/common/widgets/bars/menu_bar.dart";
import "package:food_delivery_app/data/services/user_service.dart";
import "package:food_delivery_app/features/authentication/models/account/user.dart";
import "package:food_delivery_app/features/notification/views/notification.dart";
import "package:food_delivery_app/features/user/food/views/home/home.dart";
import "package:food_delivery_app/features/user/food/views/restaurant/restaurant_like.dart";
import "package:food_delivery_app/features/user/order/views/history/order_history.dart";
import "package:food_delivery_app/features/personal/views/profile/profile.dart";
import "package:food_delivery_app/utils/constants/icon_strings.dart";
import "package:food_delivery_app/utils/helpers/helper_functions.dart";
import "package:get/get.dart";

class UserMenuController extends GetxController {
  static UserMenuController get instance => Get.find();
  // User? user;

  @override
  void onInit() {
    super.onInit();
    initializeUser();
  }

  Future<void> initializeUser() async  {
    // user = await UserService.getUser();
    // update();
  }

}

class UserMenuRedirection extends StatelessWidget {
  const UserMenuRedirection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> viewList = [
      HomeView(),
      OrderHistoryView(),
      RestaurantLikeView(),
      NotificationView(),
      PersonalProfileView(),
    ];
    final x = Get.put(UserMenuController());
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
      viewList: viewList,
      tag: "user",
    );
  }
}
