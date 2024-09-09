
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
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