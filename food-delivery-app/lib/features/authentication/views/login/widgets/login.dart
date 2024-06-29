import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/features/authentication/views/login/widgets/login_oauth.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  PhoneNumber phoneNumber = PhoneNumber();
  @override
  Widget build(BuildContext context) {
    print(phoneNumber);
    return Stack(
      children: [
        MainWrapper(
          topMargin: TDeviceUtil.getAppBarHeight() + 25,
          child: Column(
            children: [
              Text(
                "Login",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary),
              ),
              SizedBox(height: TSize.spaceBetweenSections,),

              InternationalPhoneNumberInput(onInputChanged: (s) {setState(() {
                phoneNumber = s;
              });}),
            ],
          ),
        ),
        LoginOauth(),
      ],
    );
  }
}
