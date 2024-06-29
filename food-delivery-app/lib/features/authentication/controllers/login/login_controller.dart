import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/features/authentication/views/login/verification.dart';
import 'package:food_delivery_app/features/authentication/views/login/widgets/register.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/authentication/views/login/widgets/login.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  var page = Rx<Widget>(Login());

  void showRegisterPage() {
    page.value = Register();
  }

  void showLoginPage() {
    page.value = Login();
  }

  void handleLogin() {
    print("HANDLE LOGIN");
    Get.to(() => VerificationView());
  }

  void handleRegister() {
    Get.to(() => VerificationView());
    print("HANDLE REGISTER");
  }
}
