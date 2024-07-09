import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/user/food/views/home/home.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  void homeRedirect() {
    Get.offAll(() => HomeView());
  }

  void skip() {
    Get.offAll(() => HomeView());
  }

  void handleAddImage() {}
}