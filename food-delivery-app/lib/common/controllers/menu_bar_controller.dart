
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/features/user/food/views/home/home.dart';
import 'package:food_delivery_app/features/user/food/views/like/food_like.dart';
import 'package:food_delivery_app/features/user/notification/views/notification/notification.dart';
import 'package:food_delivery_app/features/user/order/views/history/order_history.dart';
import 'package:food_delivery_app/features/user/personal/views/profile/personal_profile.dart';
import 'package:get/get.dart';

class MenuBarController extends GetxController {
  static MenuBarController get instance => Get.find();
  MenuBarController({List<Widget> ls = const []}) {
    viewList = ls;
  }

  Rx<int> currentIndex = 0.obs;
  List<Widget> viewList = [];


  Widget getView(index) {
    return viewList[currentIndex.value];
  }

  void updateIndex(value) {
    currentIndex.value = value;
  }

}