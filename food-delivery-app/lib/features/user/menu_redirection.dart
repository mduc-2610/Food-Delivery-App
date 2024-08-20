import "package:flutter/material.dart";
import "package:food_delivery_app/common/widgets/bars/menu_bar.dart";
import "package:food_delivery_app/data/services/user_service.dart";
import "package:food_delivery_app/features/notification/views/notification.dart";
import "package:food_delivery_app/features/user/food/views/home/home.dart";
import "package:food_delivery_app/features/user/food/views/like/food_like.dart";
import "package:food_delivery_app/features/user/order/views/history/order_history.dart";
import "package:food_delivery_app/features/user/personal/views/profile/profile.dart";
import "package:food_delivery_app/utils/constants/icon_strings.dart";
import "package:food_delivery_app/utils/helpers/helper_functions.dart";
import "package:get/get.dart";

class UserMenuController extends GetxController {
  static UserMenuController get instance => Get.find();
  String? user;

  @override
  void onInit() {
    super.onInit();
    initializeUser();
  }

  Future<void> initializeUser() async  {
    user = (await UserService.getUser())?.id;
  }

}

class UserMenuRedirection extends StatelessWidget {
  const UserMenuRedirection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
