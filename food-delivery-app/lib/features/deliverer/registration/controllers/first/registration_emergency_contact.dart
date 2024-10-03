import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/emergency_contact.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_first_step_controller.dart';
import 'package:get/get.dart';

class RegistrationEmergencyContactController extends GetxController {
  static RegistrationEmergencyContactController get instance => Get.find();

  final formKey = GlobalKey<FormState>();

  final registrationFirstStepController = RegistrationFirstStepController.instance;
  Deliverer? deliverer;
  DelivererEmergencyContact? emergencyContact;

  final nameController = TextEditingController();
  final relationshipController = TextEditingController();
  final phoneController = TextEditingController();

  RegistrationEmergencyContactController() {
    deliverer = registrationFirstStepController.deliverer;
    emergencyContact = deliverer?.emergencyContact;

    if (emergencyContact != null) {
      nameController.text = emergencyContact?.name ?? '';
      relationshipController.text = emergencyContact?.relationship ?? '';
      phoneController.text = emergencyContact?.phoneNumber ?? '';
    }
  }

  Future<void> onCallApi() async {
    final emergencyContactData = DelivererEmergencyContact(
      name: nameController.text,
      relationship: relationshipController.text,
      phoneNumber: phoneController.text,
    );

    if (emergencyContact != null) {
      final [statusCode, headers, data] = await APIService<DelivererEmergencyContact>()
          .update(deliverer?.id ?? "", emergencyContactData.toJson());
      print([statusCode, headers, data]);
    } else {
      if (deliverer == null) {
        var [statusCode, headers, data] = await APIService<Deliverer>()
            .create({"user": registrationFirstStepController.user?.id});
        print([statusCode, headers, data]);
        if (statusCode == 200 || statusCode == 201) {
          deliverer = data;
          registrationFirstStepController.deliverer = data;
        }
      }
      emergencyContactData.deliverer = deliverer?.id;
      print(emergencyContactData.toJson());
      final [statusCode, headers, data] = await APIService<DelivererEmergencyContact>()
          .create(emergencyContactData.toJson());
      print([statusCode, headers, data]);
    }
  }

  void onSave() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await onCallApi();
      Get.snackbar("Success", "Information saved successfully");
    }
  }

  void onContinue() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await onCallApi();
      registrationFirstStepController.setTab();
      print("Continuing with emergency contact info...");
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    relationshipController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
