import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:get/get.dart';

class RegistrationRepresentativeInfoController extends GetxController {
  static RegistrationRepresentativeInfoController get instance => Get.find();

  // Document Controllers
  final frontIdController = Get.put(RegistrationDocumentFieldController(), tag: "frontId");
  final backIdController = Get.put(RegistrationDocumentFieldController(), tag: "backId");
  final businessLicenseController = Get.put(RegistrationDocumentFieldController(), tag: "businessLicense");

  // Text Controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final idNumberController = TextEditingController();
  final taxCodeController = TextEditingController();

  // Form validation key
  final formKey = GlobalKey<FormState>();

  // Validation methods
  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tên đầy đủ không được để trống';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email không được để trống';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số điện thoại không được để trống';
    }
    final regex = RegExp(r'^\d{10}$');
    if (!regex.hasMatch(value)) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }

  String? validateIdNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số CMND không được để trống';
    }
    if (value.length < 9) {
      return 'Số CMND không hợp lệ';
    }
    return null;
  }

  String? validateTaxCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mã số thuế không được để trống';
    }
    return null;
  }

  // Method to validate form and return a boolean indicating if it's valid
  bool validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      // If form is valid, save the current state
      formKey.currentState?.save();
      return true;
    }
    return false;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    idNumberController.dispose();
    taxCodeController.dispose();
    super.onClose();
  }
}
