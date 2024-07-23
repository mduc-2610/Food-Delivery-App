import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/authentication/controllers/login/password_set_controller.dart';
import 'package:food_delivery_app/features/authentication/views/login/widgets/login_oauth.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/validators/validators.dart';
import 'package:get/get.dart';

class PasswordSetView extends StatelessWidget {
  PasswordSetView({Key? key}) : super(key: key);

  final PasswordSetController _controller = Get.put(PasswordSetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: "Set your password",
        isBigTitle: true,
      ),
      body: Stack(
        children: [
          MainWrapper(
            child: Form(
              key: _controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _controller.passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Password"),
                    obscureText: true,
                    validator: TValidator.validatePassword,
                    // Assuming onChanged is still needed
                    onChanged: (value) => _controller.passwordController.text = value,
                  ),
                  SizedBox(height: TSize.spaceBetweenInputFields),

                  TextFormField(
                    controller: _controller.confirmPasswordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Confirm Password"),
                    obscureText: true,
                    validator: (_) => TValidator.validateConfirmPassword(
                        _controller.confirmPasswordController.text,
                        _controller.passwordController.text
                    ),
                    // Assuming onChanged is still needed
                    onChanged: (value) => _controller.confirmPasswordController.text = value,
                  ),
                  SizedBox(height: TSize.spaceBetweenInputFields),

                  MainButton(
                    onPressed: _controller.handleSubmit,
                    text: 'Submit'),
                ],
              ),
            ),
          ),
          // LoginOauth(),
        ],
      ),
    );
  }
}
