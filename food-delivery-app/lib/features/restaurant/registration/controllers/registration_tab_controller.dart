import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/restaurant_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RegistrationTabController extends GetxController with GetSingleTickerProviderStateMixin {
  static RegistrationTabController get instance => Get.find();

  int currentTab = 0;
  Rx<bool> isLoading = true.obs;
  User? user;
  Restaurant? restaurant;
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    initialize();
    tabController = TabController(length: 5, vsync: this);
  }

  Future<void> initialize() async {
    isLoading.value = true;
    final [_user, _restaurant] = await RestaurantService.getRestaurant(getUser: true);
    user = _user;
    restaurant = _restaurant;
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    $print(restaurant);
  }

  void setTab() {
    tabController.animateTo(currentTab + 1);
    currentTab += 1;
  }
}