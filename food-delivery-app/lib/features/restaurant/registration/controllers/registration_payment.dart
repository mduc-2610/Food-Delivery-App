import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/payment_info.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/registration_tab_controller.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RegistrationPaymentInfoController extends GetxController {
  static RegistrationPaymentInfoController get instance => Get.find();

  final formKey = GlobalKey<FormState>();
  final registrationTabController = RegistrationTabController.instance;
  Restaurant? restaurant;
  RestaurantPaymentInfo? paymentInfo;

  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final citizenIdentificationController = TextEditingController();
  final bank = ''.obs;
  final branch = ''.obs;
  final city = ''.obs;

  RegistrationPaymentInfoController() {
    restaurant = registrationTabController.restaurant;
    paymentInfo = restaurant?.paymentInfo;

    if (paymentInfo != null) {
      accountNameController.text = paymentInfo?.accountName ?? '';
      accountNumberController.text = paymentInfo?.accountNumber ?? '';
      emailController.text = paymentInfo?.email ?? '';
      phoneController.text = paymentInfo?.phoneNumber ?? '';
      citizenIdentificationController.text = paymentInfo?.citizenIdentification ?? '';
      bank.value = paymentInfo?.bank ?? '';
      branch.value = paymentInfo?.branch ?? '';
      city.value = paymentInfo?.city ?? '';
    }
  }

  void setBank(String? value) => bank.value = value ?? '';
  void setBranch(String? value) => branch.value = value ?? '';
  void setCity(String? value) => city.value = value ?? '';

  Future<void> onCallApi() async {
    final paymentInfoData = RestaurantPaymentInfo(
      accountName: accountNameController.text,
      accountNumber: accountNumberController.text,
      email: emailController.text,
      phoneNumber: phoneController.text,
      citizenIdentification: citizenIdentificationController.text,
      bank: bank.value,
      branch: branch.value,
      city: city.value,
    );

    if (paymentInfo != null) {
      final [statusCode, headers, data] = await APIService<RestaurantPaymentInfo>()
          .update(registrationTabController.restaurant?.id ?? "", paymentInfoData, patch: true);
      print([statusCode, headers, data]);
    } else {
      if (restaurant == null) {
        var [statusCode, headers, data] = await APIService<Restaurant>()
            .create({"user": registrationTabController.user?.id});
        print([statusCode, headers, data]);
        if (statusCode == 200 || statusCode == 201) {
          restaurant = data;
          registrationTabController.restaurant = data;
        }
      }
      paymentInfoData.restaurant = restaurant?.id;
      final [statusCode, headers, data] = await APIService<RestaurantPaymentInfo>()
          .create(paymentInfoData);
      print([statusCode, headers, data]);
    }
  }

  void onSave() async {
      await onCallApi();
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      print('Saving Payment Info');
      Get.snackbar("Success", "Information saved successfully");
    }
  }

  void onContinue() async {
    await onCallApi();
    Get.snackbar("Success", "Information saved successfully");
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      registrationTabController.setTab();
    }
  }

  @override
  void onClose() {
    accountNameController.dispose();
    accountNumberController.dispose();
    emailController.dispose();
    phoneController.dispose();
    citizenIdentificationController.dispose();
    super.onClose();
  }
}
