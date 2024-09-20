import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegistrationPaymentController extends GetxController {
  // Text controllers
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final idController = TextEditingController();
  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();

  // Dropdown values
  final selectedBank = 'NH Ngoại thương Viet Nam (Vietcombank)'.obs;
  final selectedCity = RxnString();
  final selectedBranch = RxnString();

  // On Save and Continue actions
  void onSave() {
    // Implement save logic
    print('Payment details saved.');
  }

  void onContinue() {
    // Implement continue logic
    print('Proceeding with payment registration...');
  }
}
