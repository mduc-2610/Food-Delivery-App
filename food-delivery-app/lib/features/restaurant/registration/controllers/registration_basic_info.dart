import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegistrationBasicInfoController extends GetxController {
  static RegistrationBasicInfoController get instance => Get.find();

  // Form key to manage the form state
  final formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final shopNameController = TextEditingController();
  final streetController = TextEditingController();
  final contactPhoneController = TextEditingController();
  final houseStreetController = TextEditingController();

  // Dropdown selected values
  final shopType = ''.obs;
  final city = ''.obs;
  final district = ''.obs;

  // Setters for dropdown fields
  void setShopType(String? value) => shopType.value = value ?? "";
  void setCity(String? value) => city.value = value ?? "";
  void setDistrict(String? value) => district.value = value ?? "";

  // Save and Continue functions
  void onSave() {
    if (formKey.currentState!.validate()) {
      print('Saving Basic Info');
      // Save logic here
    }
  }

  void onContinue() {
    if (formKey.currentState!.validate()) {
      print('Continuing to next step');
      // Continue logic here
    }
  }
}
