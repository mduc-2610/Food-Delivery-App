import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/main_button.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/sliver_app_bar.dart';
import 'package:food_delivery_app/features/authentication/controllers/profile/profile_controller.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ProfileView extends StatelessWidget {
  final ProfileController _controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: "Your Profile",
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                MainWrapper(
                  topMargin: TSize.spaceBetweenSections,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(TSize.md),
                        decoration: BoxDecoration(
                          color: TColor.inputLightBackgroundColor,
                          borderRadius: BorderRadius.circular(TSize.borderRadiusCircle),
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Icon(
                              Icons.person_rounded,
                              size: 125,
                              color: TColor.textDesc,
                            ),
                            IconButton(
                              icon: Icon(Icons.camera_alt_rounded, color: Colors.redAccent, size: TSize.xl,),
                              onPressed: _controller.handleAddImage,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: TSize.spaceBetweenSections),

                      InternationalPhoneNumberInput(onInputChanged: (s) {}),
                      SizedBox(height: TSize.spaceBetweenInputFields),

                      TextFormField(
                        initialValue: 'thomas.abc.inc@gmail.com',
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: TSize.spaceBetweenInputFields),

                      TextFormField(
                        initialValue: 'Thomas K. Wilson',
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: TSize.spaceBetweenInputFields),

                      DateOfBirthInput(),
                      SizedBox(height: TSize.spaceBetweenInputFields),

                      GenderDropdown(),
                      SizedBox(height: TSize.spaceBetweenInputFields),

                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          labelText: 'Your Location',
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
              bottomMargin: TSize.md,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MainButton(
                    onPressed: _controller.homeRedirect,
                    text: "Continue",
                  ),
                  SizedBox(height: TSize.spaceBetweenItems),
                  MainButton(
                    onPressed: _controller.skip,
                    text: "Skip",
                    isElevatedButton: false,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class DateOfBirthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_today),
        labelText: 'Date of Birth',
      ),
    );
  }
}

class GenderDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSize.borderRadiusMd)
        )
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
        DropdownMenuItem(
          child: Text("Other"),
          value: "other",
        ),
      ],
      onChanged: (value) {},
      hint: Text("Gender"),
    );
  }
}