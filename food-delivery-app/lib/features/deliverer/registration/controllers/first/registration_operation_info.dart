import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/operation_info.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_first_step_controller.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RegistrationOperationInfoController extends GetxController {
  static RegistrationOperationInfoController get instance => Get.find();

  final formKey = GlobalKey<FormState>();

  final registrationFirstStepController = RegistrationFirstStepController.instance;
  Deliverer? deliverer;
  DelivererOperationInfo? operationInfo;

  final city = ''.obs;
  final hub = ''.obs;
  final area = ''.obs;
  final time = ''.obs;
  final driverType = 'Hub'.obs;

  RegistrationOperationInfoController() {
    deliverer = registrationFirstStepController.deliverer;
    operationInfo = deliverer?.operationInfo;

    if (operationInfo != null) {
      $print("DRIVER TYPE: ${operationInfo?.driverType}");
      city.value = operationInfo?.city ?? '';
      hub.value = operationInfo?.hub ?? '';
      area.value = operationInfo?.area ?? '';
      time.value = operationInfo?.time ?? '';
      if(operationInfo?.driverType == 'HUB') {
        driverType.value = "Hub";
      }
      else {
        driverType.value = "Part-time";
      }
    }
  }

  void setSelectedCity(String? value) => city.value = value ?? "";
  void setSelectedHub(String? value) => hub.value = value ?? "";
  void setSelectedArea(String? value) => area.value = value ?? "";
  void setSelectedTime(String? value) => time.value = value ?? "";
  void setDriverType(String? value) => driverType.value = value ?? "";

  Future<void> onCallApi() async {
    final operationInfoData = DelivererOperationInfo(
      city: city.value,
      hub: hub.value,
      area: area.value,
      time: time.value,
      driverType: driverType.value,
    );

    if (operationInfo != null) {
      final [statusCode, headers, data] = await APIService<DelivererOperationInfo>()
          .update(deliverer?.id ?? "", operationInfoData.toJson());
      print([statusCode, headers, data]);
      $print("IS UPDATED: ${operationInfoData?.toJson()}");

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
      operationInfoData.deliverer = deliverer?.id;
      $print("IS CREATED: ${operationInfoData?.toJson()}");
      final [statusCode, headers, data] = await APIService<DelivererOperationInfo>()
          .create(operationInfoData.toJson());
      print([statusCode, headers, data]);
    }
  }

  void onSave() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await onCallApi();
    }
  }

  void onContinue() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await onCallApi();
      registrationFirstStepController.setTab();
      print("Continuing with operation info...");
    }
  }
}
