import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/driver_license.dart';
import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_first_step_controller.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RegistrationDriverLicenseController extends GetxController {
  static RegistrationDriverLicenseController get instance => Get.find();

  final formKey = GlobalKey<FormState>();
  final registrationFirstStepController = RegistrationFirstStepController.instance;
  Deliverer? deliverer;
  DelivererDriverLicense? driverLicense;

  final vehicleType = ''.obs;
  final licensePlateController = TextEditingController();
  var frontLicenseController;
  var backLicenseController;
  var frontRegistrationController;
  var backRegistrationController;

  RegistrationDriverLicenseController() {
    deliverer = registrationFirstStepController.deliverer;
    driverLicense = deliverer?.driverLicense;

    if (driverLicense != null) {
      vehicleType.value = driverLicense?.vehicleType ?? '';
      licensePlateController.text = driverLicense?.licensePlate ?? '';
    }

    frontLicenseController = Get.put(RegistrationDocumentFieldController(
        databaseImages: [driverLicense?.driverLicenseFront]
    ), tag: "frontLicense");

    backLicenseController = Get.put(RegistrationDocumentFieldController(
        databaseImages: [driverLicense?.driverLicenseBack]
    ), tag: "backLicense");

    frontRegistrationController = Get.put(RegistrationDocumentFieldController(
        databaseImages: [driverLicense?.motorcycleRegistrationCertificateFront]
    ), tag: "frontRegistration");

    backRegistrationController = Get.put(RegistrationDocumentFieldController(
        databaseImages: [driverLicense?.motorcycleRegistrationCertificateBack]
    ), tag: "backRegistration");
  }

  void setVehicleType(String? value) => vehicleType.value = value ?? '';

  Future<void> onCallApi() async {
    final driverLicenseData = DelivererDriverLicense(
      vehicleType: vehicleType.value,
      licensePlate: licensePlateController.text,
      driverLicenseFront: frontLicenseController.selectedImages.isNotEmpty
          ? frontLicenseController.selectedImages[0]
          : null,
      driverLicenseBack: backLicenseController.selectedImages.isNotEmpty
          ? backLicenseController.selectedImages[0]
          : null,
      motorcycleRegistrationCertificateFront: frontRegistrationController.selectedImages.isNotEmpty
          ? frontRegistrationController.selectedImages[0]
          : null,
      motorcycleRegistrationCertificateBack: backRegistrationController.selectedImages.isNotEmpty
          ? backRegistrationController.selectedImages[0]
          : null,
    );
    if (driverLicense != null) {
      final [statusCode, headers, data] = await APIService<DelivererDriverLicense>(dio: Dio())
          .update(registrationFirstStepController.deliverer?.id ?? "", driverLicenseData, isFormData: true, patch: true);
      $print([statusCode, headers, data]);
    } else {
      if (deliverer == null) {
        var [statusCode, headers, data] = await APIService<DelivererDriverLicense>()
            .create({"user": registrationFirstStepController.user?.id});
        $print([statusCode, headers, data]);
        if (statusCode == 200 || statusCode == 201) {
          deliverer = data;
          registrationFirstStepController.deliverer = data;
        }
      }
      driverLicenseData.deliverer = deliverer?.id;
      final [statusCode, headers, data] = await APIService<DelivererDriverLicense>(dio: Dio())
          .create(driverLicenseData, isFormData: true);
      print([statusCode, headers, data]);
    }
  }

  void onSave() async {
    await onCallApi();
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
    }
  }

  void onContinue() async {
    await onCallApi();
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      registrationFirstStepController.setTab();
      print("Continuing with driver license info...");
    }
  }

  @override
  void onClose() {
    licensePlateController.dispose();
    super.onClose();
  }
}
