import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/residency_info.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_first_step_controller.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RegistrationResidencyInfoController extends GetxController {
  static RegistrationResidencyInfoController get instance => Get.find();

  final formKey = GlobalKey<FormState>();

  final registrationFirstStepController = RegistrationFirstStepController.instance;
  Deliverer? deliverer;
  DelivererResidencyInfo? residencyInfo;

  final isSameAsCI = true.obs;
  final hasTaxNumber = false.obs;
  final city = ''.obs;
  final district = ''.obs;
  final ward = ''.obs;
  final addressController = TextEditingController();
  final taxNumberController = TextEditingController();
  final emailController = TextEditingController();

  RegistrationResidencyInfoController() {
    deliverer = registrationFirstStepController.deliverer;
    residencyInfo = deliverer?.residencyInfo;
    if (residencyInfo != null) {
      isSameAsCI.value = residencyInfo?.isSameAsCI ?? true;
      city.value = residencyInfo?.city ?? '';
      district.value = residencyInfo?.district ?? '';
      ward.value = residencyInfo?.ward ?? '';
      addressController.text = residencyInfo?.address ?? '';
      taxNumberController.text = residencyInfo?.taxCode ?? '';
      hasTaxNumber.value = residencyInfo?.taxCode?.isNotEmpty ?? false;
      emailController.text = residencyInfo?.email ?? '';
    }
  }

  void toggleIsSameAsCI(bool value) => isSameAsCI.value = value;
  void toggleHasTaxNumber(bool value) {
    hasTaxNumber.value = value;
    taxNumberController.text = "";
  }
  void setResidentCity(String? value) => city.value = value ?? "";
  void setResidentDistrict(String? value) => district.value = value ?? "";
  void setResidentWard(String? value) => ward.value = value ?? "";

  Future<void> onCallApi() async {
    final residencyInfoData = DelivererResidencyInfo(
      isSameAsCI: isSameAsCI.value,
      email: emailController.text,
      city: city.value,
      district: district.value,
      ward: ward.value,
      address: addressController.text,
      taxCode: hasTaxNumber.value ? taxNumberController.text : null,
    );
    $print(residencyInfoData.toJson());

    if (residencyInfo != null) {
      final [statusCode, headers, data] = await APIService<DelivererResidencyInfo>()
          .update(deliverer?.id ?? "", residencyInfoData.toJson());
      $print([statusCode, headers, data]);
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
      residencyInfoData.deliverer = deliverer?.id;
      final [statusCode, headers, data] = await APIService<DelivererResidencyInfo>()
          .create(residencyInfoData.toJson());
      $print([statusCode, headers, data]);
    }
  }

  void onSave() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await onCallApi();
      print("Saved Residency Information");
    }
  }

  void onContinue() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await onCallApi();
      registrationFirstStepController.setTab();
      print("Continuing to next step");
    }
  }

  @override
  void onClose() {
    addressController.dispose();
    taxNumberController.dispose();
    super.onClose();
  }
}