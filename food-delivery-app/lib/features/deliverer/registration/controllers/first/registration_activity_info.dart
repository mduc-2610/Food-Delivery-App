import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegistrationActivityInfoController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final selectedCity = ''.obs;
  final selectedHub = ''.obs;
  final selectedArea = ''.obs;
  final selectedTime = ''.obs;
  final selectedDriverType = 'Tài xế HUB'.obs;

  void setSelectedCity(String? value) => selectedCity.value = value ?? "";
  void setSelectedHub(String? value) => selectedHub.value = value ?? "";
  void setSelectedArea(String? value) => selectedArea.value = value ?? "";
  void setSelectedTime(String? value) => selectedTime.value = value ?? "";
  void setDriverType(String? value) => selectedDriverType.value = value ?? "";

  void onSave() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      print("Saved form with details: City - ${selectedCity.value}, Hub - ${selectedHub.value}, Area - ${selectedArea.value}, Time - ${selectedTime.value}, Driver Type - ${selectedDriverType.value}");
    }
  }

  void onContinue() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      print("Continuing to the next step");
    }
  }
}
