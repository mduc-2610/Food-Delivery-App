import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RegistrationDriverLicenseController extends GetxController {
  final frontLicense = Get.put(RegistrationDocumentFieldController(), tag: "frontLicense");
  final backLicense = Get.put(RegistrationDocumentFieldController(), tag: "backLicense");
  final vehicleType = 'Select'.obs;
  final licensePlate = TextEditingController();
  final frontRegistration = Get.put(RegistrationDocumentFieldController(), tag: "frontRegistration");
  final backRegistration = Get.put(RegistrationDocumentFieldController(), tag: "backRegistration");

  void setVehicleType(String? value) => vehicleType.value = value ?? "";

  void onSave() {
    $print("${frontLicense.selectedImages[0].path}");
    // Implement save logic here
    print('Saving Driver License Information');
    // You can access images like this: frontLicense.images
  }

  void onContinue() {
    // Implement continue logic here
    print('Continuing to next step');
  }
}