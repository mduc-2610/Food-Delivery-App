import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme(value) {
    Get.changeThemeMode(value? ThemeMode.dark : ThemeMode.light);
    isDarkMode.value = !isDarkMode.value;
  }
}
