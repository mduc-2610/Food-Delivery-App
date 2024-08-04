import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/token_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/profile.dart';
import 'package:food_delivery_app/features/authentication/models/account/setting.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class PersonalProfileController extends GetxController {
  static PersonalProfileController get instance => Get.find();

  // var user = Rxn<User>();
  Token? token;
  User? user;
  UserSetting? setting;
  UserProfile? profile;
  Rx<bool> darkMode = false.obs;
  Rx<bool> notification = false.obs;
  Rx<bool> sound = false.obs;
  Rx<bool> automaticallyUpdated = false.obs;
  Rx<String> language = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  void loadUser() async {
    token = await TokenService.getToken();
    user = await APIService<Me>(token: token, pagination: false).list();
    setting = user?.setting;
    darkMode.value = setting?.darkMode ?? false;
    notification.value = setting?.notification ?? false;
    sound.value = setting?.sound ?? false;
    automaticallyUpdated.value = setting?.automaticallyUpdated ?? false;
    language.value = setting?.language ?? "English";
    profile = user?.profile;
    $print(user);
  }

  void toggleTheme(value) {
    Get.changeThemeMode(value? ThemeMode.dark : ThemeMode.light);
    darkMode.value = !darkMode.value;
    updateSetting(UserSetting(darkMode: darkMode.value));

  }

  void toggleNotification(bool value) {
    notification.value = value;
    updateSetting(UserSetting(notification: notification.value));
  }

  void toggleSound(bool value) {
    sound.value = value;
    updateSetting(UserSetting(sound: sound.value));
  }

  void toggleAutomaticallyUpdated(bool value) {
    automaticallyUpdated.value = value;
    updateSetting(UserSetting(automaticallyUpdated: automaticallyUpdated.value));
  }

  void changeLanguage(value) {
    language.value = value;
    updateSetting(UserSetting(language: language.value));
  }

  Future<void> updateSetting(UserSetting updatedSettings) async {
    $print(updatedSettings);
    await APIService<UserSetting>(token: token).update(setting?.user, updatedSettings, patch: true);
  }
}