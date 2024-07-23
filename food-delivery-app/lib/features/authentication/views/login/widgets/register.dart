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

class Register extends StatefulWidget {
  const Register({
    super.key
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _controller = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainWrapper(
          topMargin: TDeviceUtil.getAppBarHeight() + 25,
          child: Column(
            children: [
              Text(
                "Registration",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary),
              ),
              SizedBox(height: TSize.spaceBetweenSections,),

              Column(
                children: [
                  Obx(() => InternationalPhoneNumberInput(
                    onInputChanged: _controller.onPhoneNumberChange,
                    initialValue: _controller.phoneNumber.value,
                    textFieldController: TextEditingController(
                        text: THelperFunction.getPhoneNumber(_controller.phoneNumber.value, excludePrefix: true)
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
        LoginOauth(isLogin: false,)
      ],
    );
  }
}
