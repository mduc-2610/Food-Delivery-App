import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/fields/date_picker.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/profile_picture_selection.dart';
import 'package:food_delivery_app/features/authentication/controllers/login/auth_controller.dart';
import 'package:food_delivery_app/features/authentication/controllers/profile/profile_controller.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:food_delivery_app/utils/validators/validators.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ProfileView extends StatelessWidget {
  final ProfileController _controller = Get.put(ProfileController());
  final AuthController _authController = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Your Profile",
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                MainWrapper(
                  child: Column(
                    children: [
                      ProfilePictureSelection(onPressed: _controller.handleAddImage),
                      SizedBox(height: TSize.spaceBetweenSections),

                      InternationalPhoneNumberInput(
                        onInputChanged: null,
                        isEnabled: false,
                        initialValue: _authController.phoneNumber.value,
                        textFieldController: TextEditingController(text: THelperFunction.getPhoneNumber(_authController.phoneNumber.value, excludePrefix: true)),
                      ),
                      SizedBox(height: TSize.spaceBetweenInputFields),

                      Form(
                        key: _controller.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _controller.emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(TIcon.email),
                                labelText: 'Email',
                              ),
                              validator: TValidator.validateEmail,
                            ),
                            SizedBox(height: TSize.spaceBetweenInputFields),

                            TextFormField(
                              controller: _controller.nameController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(TIcon.person),
                                labelText: 'Name',
                              ),
                              validator: TValidator.validateTextField,
                            ),
                            SizedBox(height: TSize.spaceBetweenInputFields),

                            CDatePicker(
                              controller: _controller.dateController,
                              xcontroller: _controller,
                              labelText: 'Date of birth',
                              hintText: "dd/MM/yyyy",
                              datePattern: 'dd/MM/yyyy',
                              validator: TValidator.validateTextField,
                            ),
                            SizedBox(height: TSize.spaceBetweenInputFields),

                            DropdownButtonFormField2<String>(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(TSize.borderRadiusMd),
                                ),
                              ),
                              items: [
                                DropdownMenuItem(
                                  child: Text("Male"),
                                  value: "male",
                                ),
                                DropdownMenuItem(
                                  child: Text("Female"),
                                  value: "female",
                                ),
                              ],
                              onChanged: _controller.onGenderChange,
                              hint: Text("Gender"),
                              validator: TValidator.validateTextField,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: MainWrapper(
              bottomMargin: 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MainButton(
                    onPressed: _controller.handleContinue,
                    text: "Continue",
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),
                  MainButton(
                    onPressed: _controller.handleSkip,
                    text: "Skip",
                    isElevatedButton: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}