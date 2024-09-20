import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationEmergencyContactController extends GetxController {
  static RegistrationEmergencyContactController get instance => Get.find();

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final relationController = TextEditingController();
  final phoneController = TextEditingController();

  void onSave() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      print("Saving emergency contact: ${nameController.text}");
    }
  }

  void onContinue() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      print("Continuing with emergency contact info...");
    }
  }
}
