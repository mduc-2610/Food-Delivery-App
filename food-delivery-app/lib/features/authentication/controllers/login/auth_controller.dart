import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/snack_bar.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/token_service.dart';
import 'package:food_delivery_app/features/authentication/controllers/login/verification_controller.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/auth/login_password.dart';
import 'package:food_delivery_app/features/authentication/models/auth/send_otp.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/features/authentication/models/message.dart';
import 'package:food_delivery_app/features/authentication/views/login/password_set.dart';
import 'package:food_delivery_app/features/authentication/views/login/verification.dart';
import 'package:food_delivery_app/features/authentication/views/login/widgets/register.dart';
import 'package:food_delivery_app/features/notification/models/message.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/main.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/authentication/views/login/widgets/login.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:top_snackbar/top_snackbar.dart';


class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  var loginType = "Login with SMS".obs;
  Rx<bool> isForgotPassword = false.obs;
  Rx<String> password = "".obs;
  Rx<PhoneNumber> phoneNumber = PhoneNumber(
      isoCode: "VN",
  ).obs;
  late var page;
  late User user;
  late OTP otp;
  late Token token;
  int? timeDuration;

  var timer = 45.obs;
  var isCodeSent = false.obs;
  Timer? _countdownTimer;

  @override
  void onInit() {
    // startTimer();
    page = Rx<Widget>(Login());
    super.onInit();
  }

  void showRegisterPage() {
    page.value = Register();
  }

  void showLoginPage() {
    page.value = Login();
  }

  void handleLoginType() {
    isForgotPassword.value = false;
    loginType.value = (loginType.value == "Login with SMS")
        ? "Login with Password" : "Login with SMS";
  }

  void handleForgotPasswordType() {
    handleLoginType();
    isForgotPassword.value = true;
    THelperFunction.showCSnackBar(
        Get.context!,
        "Please provide your phone number to proceed with password setup.",
        SnackBarType.info,
        duration: 10
    );
  }

  void onPasswordChange(value) {
    password.value = value;
  }

  void onPhoneNumberChange(value) {
    phoneNumber.value = value;
  }

  Future<List<dynamic>> getOTPByPhoneNumber() async {
    final sendOTPData = SendOTP(
        phoneNumber: phoneNumber.value,
        isForgotPassword: isForgotPassword.value,
    );
    $print(sendOTPData);
    final [statusCode, headers, body] = await callCreateAPI(
        "account/user/send-otp",
        sendOTPData.toJson(),
        "",
        fullResponse: true
    );
    if(statusCode == 200) {
      user = User.fromJson(body["data"]["user"]);
      otp = OTP.fromJson(body["data"]["otp"]);
    }
    $print(body);
    return [statusCode, headers, body];
  }

  void handleLogin() async {
    if(loginType.value == "Login with SMS") {
      final loginPasswordData = LoginPassword(
          phoneNumber: phoneNumber.value,
          password: password.value
      );
      final [statusCode, headers, body] = await callCreateAPI(
        "account/user/login-password",
        loginPasswordData.toJson(),
        "",
        fullResponse: true
      );
      if(statusCode == 200) {
        token = Token.fromJson(body);
        await TokenService.saveToken(token);
        Get.offAll(() => UserMenuRedirection());
      }
      else {
        final message = RMessage.fromJson(body ?? "");
        THelperFunction.showCSnackBar(
          Get.context!,
          message.message,
          SnackBarType.error,
        );
      }
    }
    else if(loginType.value == "Login with Password"){
      startTimer();
    }
  }

  void startTimer() async {
    final [statusCode, headers, body] = await getOTPByPhoneNumber();
    if(body["non_field_errors"][0] == "This phone number has not been registered yet.") {
      THelperFunction.showCSnackBar(
          Get.context!,
          body["non_field_errors"][0],
          SnackBarType.error
      );
      return;
    }
    if(statusCode == 400) {
      timer.value = THelperFunction.secondsUntilExpiration(otp.expiredAt!);
    }
    else {
      stopTimer();
      timer.value = 45;
      THelperFunction.showCSnackBar(Get.context!, "New Verification Code sent", SnackBarType.success);
      isCodeSent.value = true;

      _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (this.timer.value == 0) {
          stopTimer();
          isCodeSent.value = false;
        } else {
          this.timer.value--;
        }
      });
      Get.to(() => VerificationView());
    }
  }

  void stopTimer() {
    if(_countdownTimer != null)
      _countdownTimer?.cancel();
  }


  void handleRegister() {
    startTimer();
    Get.to(() => VerificationView());
    $print("HANDLE REGISTER");
  }

  bool get checkPhoneNumber => phoneNumber.value.phoneNumber != "+84" && phoneNumber.value.phoneNumber != null;
  bool get isLoginButtonEnabled => checkPhoneNumber && (password.value.isNotEmpty || loginType.value == "Login with Password");
  bool get isRegisterButtonEnabled => checkPhoneNumber;
}
