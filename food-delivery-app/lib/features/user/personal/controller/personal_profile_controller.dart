import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/profile.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/account/setting.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class PersonalProfileController extends GetxController {
  static PersonalProfileController get instance => Get.find();

  User? user;
  UserSetting? setting;
  UserProfile? profile;

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    user = await UserService.getUser();
    setting = user?.setting;
    profile = user?.profile;
    isLoading.value = false;
    update();
    await Future.delayed(Duration(milliseconds: TTime.init));
    $print(user);
  }

  void toggleTheme(bool value) {
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    setting?.darkMode = value;
    updateSetting(setting!);
    update();
  }

  void toggleNotification(bool value) {
    setting?.notification = value;
    updateSetting(setting!);
    update();
  }

  void toggleSound(bool value) {
    setting?.sound = value;
    updateSetting(setting!);
    update();
  }

  void toggleAutomaticallyUpdated(bool value) {
    setting?.automaticallyUpdated = value;
    updateSetting(setting!);
    update();
  }

  void changeLanguage(String value) {
    setting?.language = value;
    updateSetting(setting!);
    update();
  }

  Future<void> updateSetting(UserSetting updatedSettings) async {
    $print(updatedSettings);
    await APIService<UserSetting>().update(setting?.user, updatedSettings, patch: true);
  }
}
