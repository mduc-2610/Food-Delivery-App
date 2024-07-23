import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/token_service.dart';
import 'package:food_delivery_app/features/authentication/controllers/login/auth_controller.dart';
import 'package:food_delivery_app/features/authentication/models/account/profile.dart';
import 'package:food_delivery_app/features/user/food/views/home/home.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final AuthController authController = AuthController.instance;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dateController = TextEditingController();
  String gender = "";
  DateTime? selectedDate;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    dateController.dispose();
    super.onClose();
  }

  void onGenderChange(String? value) {
    gender = value ?? "";
    $print(gender);
  }

  void handleContinue() async {
    if (formKey.currentState?.validate() ?? false) {
      final profileData = UserProfile(
        name: nameController.text,
        dateOfBirth: selectedDate,
        gender: gender.toUpperCase()
      );
      $print(profileData);

      final data = await callUpdateAPI(
          'account/profile',
          authController.user.id,
          profileData.toJson(),
          "",
      );
      print(data);
      await TokenService.saveToken(authController.token);
      Get.offAll(() => UserMenuRedirection());
    }
  }

  void handleSkip() async {
    await TokenService.saveToken(authController.token);
    Get.offAll(() => UserMenuRedirection());
  }

  void handleAddImage() {

  }
}
