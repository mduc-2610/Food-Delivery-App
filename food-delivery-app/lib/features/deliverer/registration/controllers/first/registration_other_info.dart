import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegistrationOtherInfoController extends GetxController {
  static RegistrationOtherInfoController get instance => Get.find();

  final occupation = ''.obs;
  final detailsController = TextEditingController();

  void setOccupation(String? value) => occupation.value = value ?? '';

  void onSave() {
    // Save logic here
    print("Saving other info with occupation: ${occupation.value}");
  }

  void onContinue() {
    // Continue logic here
    print("Continuing with other info...");
  }
}
