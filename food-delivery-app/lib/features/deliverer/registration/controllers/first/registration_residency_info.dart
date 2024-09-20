import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RegistrationResidencyInfoController extends GetxController {
  static RegistrationResidencyInfoController get instance => Get.find();

  final formKey = GlobalKey<FormState>();

  final isSameAsCCCD = true.obs;
  final hasTaxNumber = false.obs;

  final cityController = TextEditingController(text: 'Hà Nội');
  final districtController = TextEditingController(text: 'Quận Hai Bà Trưng');
  final wardController = TextEditingController(text: 'Phường Bách Khoa');
  final addressController = TextEditingController(text: 'Trần Đại Nghĩa');
  final taxNumberController = TextEditingController();

  void toggleIsSameAsCCCD(bool value) {
    isSameAsCCCD.value = value;
  }

  void toggleHasTaxNumber(bool value) {
    hasTaxNumber.value = value;
  }

  void onSave() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print("Saved Residency Information");
      $print(taxNumberController.text);
      // Save logic here
    }
  }

  void onContinue() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print("Continuing to next step");
      // Continue logic here
    }
  }
}
