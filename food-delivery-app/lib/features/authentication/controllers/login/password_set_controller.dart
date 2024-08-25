import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/token_service.dart';
import 'package:food_delivery_app/features/authentication/controllers/login/auth_controller.dart';
import 'package:food_delivery_app/features/authentication/models/auth/set_password.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/features/authentication/views/profile/profile.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class PasswordSetController extends GetxController {
  static PasswordSetController get instance => Get.find();

  final AuthController authController = AuthController.instance;
  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void handleSubmit() async {
    if (formKey.currentState?.validate() ?? false) {
      final setPasswordData = SetPassword(
        user: authController.user.id!,
        password1: passwordController.text,
        password2: confirmPasswordController.text,
      );

      final [statusCode, headers, body] = await APIService<SetPassword>().create(setPasswordData, noFromJson: true);

      if (statusCode == 201) {
        authController.token = Token.fromJson(body);
        $print("CHECK: ${authController.user.isRegistrationVerified}");
        if(authController.user.isRegistrationVerified ?? true) {
          await TokenService.saveToken(authController.token);
          Get.offAll(() => UserMenuRedirection());
        }
        else {
          Get.to(ProfileView());
        }
      } else {
        print("Error: $statusCode");
      }
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
