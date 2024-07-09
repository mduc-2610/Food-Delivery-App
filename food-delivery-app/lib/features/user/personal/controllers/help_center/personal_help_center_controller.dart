import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/user/personal/views/help_center/personal_help_detail.dart';
import 'package:get/get.dart';

class PersonalHelpCenterController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  final RxInt selectedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void navigateToDetail(String title, String content) {
    Get.to(PersonalHelpDetailView(title: title, content: content));
  }
}
