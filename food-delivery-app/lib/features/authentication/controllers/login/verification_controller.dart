import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/token_service.dart';
import 'package:food_delivery_app/features/authentication/controllers/login/auth_controller.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/features/authentication/models/auth/verify_otp.dart';
import 'package:food_delivery_app/features/authentication/models/message.dart';
import 'package:food_delivery_app/features/authentication/views/login/password_set.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  static VerificationController get instance => Get.find();

  final AuthController _authController = AuthController.instance;

  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;

  VerificationController() {
    focusNodes = List.generate(4, (index) => FocusNode());
    controllers = List.generate(4, (index) => TextEditingController());
  }

  void handleInputChange(String value, int index) {
    int caretOffSet = controllers[index].selection.baseOffset;
    if (value.isNotEmpty) {
      $print("$value: ${controllers[index].text}: ${caretOffSet}");
      controllers[index].text = caretOffSet == 1
          ? value[0] : value[value.length - 1];
      if (index < 3) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
      }
    }
  }

  void handleVerify() async {
    final verifyOTPData = VerifyOTP(
      code: controllers.map((controller) => controller.text).join(''),
      user: _authController.user.id!,
      isLogin: true,
    );
    final [statusCode, headers, body] = await APIService<VerifyOTP>().create(verifyOTPData);

    if(statusCode == 400) {
      THelperFunction.showCSnackBar(Get.context!, body["non_field_errors"][0], SnackBarType.error);
    }
    else {
      if(!_authController.isForgotPassword.value) {
        if(statusCode == 201) {
          await TokenService.saveToken(Token.fromJson(body));
          Get.offAll(() => UserMenuRedirection());
        }
        else if(statusCode == 200){
          final message = RMessage(message: body["message"] ?? "");
          Get.to(() => PasswordSetView());
          THelperFunction.showCSnackBar(
              Get.context!,
              message.message,
              SnackBarType.success
          );
        }
      } else {
        Get.to(() => PasswordSetView());
        THelperFunction.showCSnackBar(
            Get.context!,
            "Verification successful! You can now reset your password.",
            SnackBarType.success,
            duration: 5
        );
      }
      $print(body);
    }
  }

  void loginRedirect() {
    Get.back();
  }

  @override
  void onClose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
