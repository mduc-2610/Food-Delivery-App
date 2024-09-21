import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/other_info.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_first_step_controller.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RegistrationOtherInfoController extends GetxController {
  static RegistrationOtherInfoController get instance => Get.find();

  final formKey = GlobalKey<FormState>();
  final registrationFirstStepController = RegistrationFirstStepController.instance;
  Deliverer? deliverer;
  DelivererOtherInfo? otherInfo;

  final occupation = ''.obs;
  final detailsController = TextEditingController();
  late RegistrationDocumentFieldController judicialRecordController;

  RegistrationOtherInfoController() {
    deliverer = registrationFirstStepController.deliverer;
    otherInfo = deliverer?.otherInfo;

    if (otherInfo != null) {
      occupation.value = otherInfo?.occupation ?? '';
      detailsController.text = otherInfo?.details ?? '';
    }
    judicialRecordController = Get.put(RegistrationDocumentFieldController(
        databaseImages: [otherInfo?.judicialRecord]),
        tag: "judicialRecord");
  }

  void setOccupation(String? value) => occupation.value = value ?? '';

  Future<void> onCallApi() async {
    final otherInfoData = DelivererOtherInfo(
        occupation: occupation.value,
        details: detailsController.text,
        judicialRecord: judicialRecordController.selectedImages[0]
    );
    if (otherInfo != null) {
      $print(otherInfoData.toJson(patch: true));
      final [statusCode, headers, data] = await APIService<DelivererOtherInfo>(dio: Dio())
          .update(deliverer?.id ?? "", otherInfoData, isFormData: true, patch: true);
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
      otherInfoData.deliverer = deliverer?.id;
      print(otherInfoData.toFormData());
      final [statusCode, headers, data] = await APIService<DelivererOtherInfo>(dio: Dio())
          .create(otherInfoData, isFormData: true);
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
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await onCallApi();
      registrationFirstStepController.setTab();
      print("Continuing with other info...");
    }
  }

  @override
  void onClose() {
    detailsController.dispose();
    super.onClose();
  }
}
