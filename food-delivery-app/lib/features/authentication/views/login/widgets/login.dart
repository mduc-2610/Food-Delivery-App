import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/authentication/controllers/login/auth_controller.dart';
import 'package:food_delivery_app/features/authentication/views/login/widgets/login_oauth.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Login extends StatefulWidget {
  const Login({
    super.key
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _controller = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainWrapper(
          topMargin: TDeviceUtil.getAppBarHeight() + 25,
          child: Column(
            children: [
              Obx(() => Text(
                (!_controller.isForgotPassword.value) ? "Login" : "Forgot Password",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary),
              )),
              SizedBox(height: TSize.spaceBetweenSections,),

              Column(
                children: [
                  Obx(() => InternationalPhoneNumberInput(
                    onInputChanged: _controller.onPhoneNumberChange,
                    textFieldController: TextEditingController(
                        text: THelperFunction.getPhoneNumber(_controller.phoneNumber.value, excludeZero: true)
                    ),
                    initialValue: _controller.phoneNumber.value,
                  )),
                  SizedBox(height: TSize.spaceBetweenInputFields,),

                  Obx(() => (_controller.loginType == "Login with SMS") ? Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(width: 1, color: TColor.primary)
                                  )
                                ),
                                child: InkWell(
                                    onTap: _controller.handleForgotPasswordType,
                                    child: Text(
                                        "Forgot?",
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.primary)
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                        obscureText: true,
                        onChanged: _controller.onPasswordChange,
                      ),
                      SizedBox(height: TSize.spaceBetweenInputFields,)
                    ],
                  ) : SizedBox(),),

                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: _controller.handleLoginType,
                        child: Text(
                          _controller.loginType.value,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: TColor.primary),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ],
          ),
        ),
        LoginOauth()
      ],
    );
  }
}
