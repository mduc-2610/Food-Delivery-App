import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/basic_info.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RegistrationBasicInfoController extends GetxController {
  static RegistrationBasicInfoController get instance => Get.find();

  RegistrationBasicInfoController({ DelivererBasicInfo? basicInfo });

  final formKey = GlobalKey<FormState>();

  final fullName = TextEditingController();
  final givenName = TextEditingController();
  final gender = ''.obs;
  final birthDate = DateTime.now().obs;
  final hometown = ''.obs;
  final residentCity = ''.obs;
  final residentDistrict = ''.obs;
  final residentWard = ''.obs;
  final address = TextEditingController();
  final idNumber = TextEditingController();
  final dateController = TextEditingController();

  void setGender(String? value) => gender.value = value ?? "";
  void setBirthDate(DateTime? date) => birthDate.value = date ?? DateTime.now();
  void setHometown(String? value) => hometown.value = value ?? "";
  void setResidentCity(String? value) => residentCity.value = value ?? "";
  void setResidentDistrict(String? value) => residentDistrict.value = value ?? "";
  void setResidentWard(String? value) => residentWard.value = value ?? "";

  void onSave() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      $print(fullName);
      $print(givenName);
      $print(gender.value);
      $print(birthDate.value);
      $print(hometown.value);
      $print(residentCity.value);
      $print(residentDistrict.value);
      $print(residentWard.value);
      $print(address);
      $print(idNumber);
      $print(birthDate);
    }
  }

  void onContinue() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      print("Continuing with registration process...");
      // Add continue logic here
    }
  }
}
