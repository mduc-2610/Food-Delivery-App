import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  void homeRedirect() {
    Get.to(() => Placeholder());
  }

  void skip() {
    Get.to(() => Placeholder());
  }

  void handleAddImage() {}
}