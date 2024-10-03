import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/representative_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/registration_tab_controller.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RegistrationRepresentativeInfoController extends GetxController {
  static RegistrationRepresentativeInfoController get instance => Get.find();

  final formKey = GlobalKey<FormState>();
  final registrationTabController = RegistrationTabController.instance;
  Restaurant? restaurant;
  RestaurantRepresentativeInfo? representativeInfo;

  final registrationType = 'Individual'.obs;
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final otherPhoneController = TextEditingController();
  final taxCodeController = TextEditingController();
  final citizenIdentificationController = TextEditingController();
  late RegistrationDocumentFieldController citizenIdentificationFrontController;
  late RegistrationDocumentFieldController citizenIdentificationBackController;
  late RegistrationDocumentFieldController businessRegistrationImageController;

  RegistrationRepresentativeInfoController() {
    restaurant = registrationTabController.restaurant;
    representativeInfo = restaurant?.representativeInfo;

    if (representativeInfo != null) {
      registrationType.value = THelperFunction.formatChoice(representativeInfo?.registrationType ?? "", reverse: true);
      fullNameController.text = representativeInfo?.fullName ?? '';
      emailController.text = representativeInfo?.email ?? '';
      phoneController.text = representativeInfo?.phoneNumber ?? '';
      otherPhoneController.text = representativeInfo?.otherPhoneNumber ?? '';
      taxCodeController.text = representativeInfo?.taxCode ?? '';
      citizenIdentificationController.text = representativeInfo?.citizenIdentification ?? '';
    }

    citizenIdentificationFrontController = Get.put(RegistrationDocumentFieldController(
        databaseImages: [representativeInfo?.citizenIdentificationFront]
    ), tag: "citizenIdentificationFront");

    citizenIdentificationBackController = Get.put(RegistrationDocumentFieldController(
        databaseImages: [representativeInfo?.citizenIdentificationBack]
    ), tag: "citizenIdentificationBack");

    businessRegistrationImageController = Get.put(RegistrationDocumentFieldController(
        databaseImages: [representativeInfo?.businessRegistrationImage]
    ), tag: "businessRegistrationImage");
  }

  void setRegistrationType(String? value) => registrationType.value = value ?? '';

  Future<void> onCallApi() async {
    final representativeInfoData = RestaurantRepresentativeInfo(
      registrationType: registrationType.value,
      fullName: fullNameController.text,
      email: emailController.text,
      phoneNumber: phoneController.text,
      otherPhoneNumber: otherPhoneController.text,
      taxCode: taxCodeController.text,
      citizenIdentification: citizenIdentificationController.text,
      citizenIdentificationFront: citizenIdentificationFrontController.selectedImages[0],
      citizenIdentificationBack: citizenIdentificationBackController.selectedImages[0],
      businessRegistrationImage: businessRegistrationImageController.selectedImages[0],
    );
    $print("RESTAURANT:$restaurant");
    if (restaurant != null && representativeInfo != null) {
      $print(representativeInfoData.toJson(patch: true));
      final [statusCode, headers, data] = await APIService<RestaurantRepresentativeInfo>(dio: Dio())
          .update(restaurant?.id ?? "", representativeInfoData, isFormData: true, patch: true);
      $print([statusCode, headers, data]);
    } else {
      if (restaurant == null) {
        var [statusCode, headers, data] = await APIService<Restaurant>()
            .create({"user": registrationTabController.user?.id});
        $print([statusCode, headers, data]);
        if (statusCode == 200 || statusCode == 201) {
          restaurant = data;
          registrationTabController.restaurant = data;
        }
      }
      representativeInfoData.restaurant = restaurant?.id;
      $print(representativeInfoData?.toJson());
      final [statusCode, headers, data] = await APIService<RestaurantRepresentativeInfo>(dio: Dio())
          .create(representativeInfoData, isFormData: true);
      print([statusCode, headers, data]);
    }
  }

  void onSave() async {
    await onCallApi();
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      Get.snackbar("Success", "Information saved successfully");
    }
  }

  void onContinue() async {
    await onCallApi();
    print('Continuing to next step');
    registrationTabController.setTab();
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      print("Continuing with representativeInfo info...");
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    otherPhoneController.dispose();
    super.onClose();
  }
}