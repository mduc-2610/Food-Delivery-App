import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/fields/date_picker.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/misc/profile_picture_selection.dart';
import 'package:food_delivery_app/common/widgets/skeleton/avatar_skeleton.dart';
import 'package:food_delivery_app/common/widgets/skeleton/field_skeleton.dart';
import 'package:food_delivery_app/common/widgets/skeleton/list_field_skeleton.dart';
import 'package:food_delivery_app/features/authentication/controllers/profile/profile_controller.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:food_delivery_app/utils/validators/validators.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ProfileDetail extends StatefulWidget {
  final bool isEdit;
  const ProfileDetail({
    this.isEdit = false,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  ProfileController? controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeController();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _initializeController() async {
    controller = Get.put(ProfileController(isEdit: widget.isEdit), tag: UniqueKey().toString());
    await Future.delayed(Duration(milliseconds: TTime.init));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: TTime.animation),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: isLoading ? _buildSkeleton() : _buildProfileForm(),
      ),
    );
  }

  Widget _buildSkeleton() {
    return Column(
      children: [
        AvatarSkeleton(),
        SizedBox(height: TSize.spaceBetweenInputFields,),
        ListFieldSkeleton(length: 5),
        SizedBox(height: TSize.spaceBetweenInputFields,),
        (!widget.isEdit)
        ? ListFieldSkeleton(length: 2)
        : FieldSkeleton(),
        SizedBox(height: TSize.spaceBetweenSections,),
      ],
    );
  }

  Widget _buildProfileForm() {
    return Column(
      children: [
        ProfilePictureSelection(onPressed: controller!.handleAddImage),
        SizedBox(height: TSize.spaceBetweenSections),
        Obx(() => InternationalPhoneNumberInput(
          onInputChanged: null,
          isEnabled: controller!.isEdit,
          initialValue: controller!.phoneNumber.value,
          textFieldController: TextEditingController(
            text: THelperFunction.getPhoneNumber(controller!.phoneNumber.value, excludePrefix: true),
          ),
        )),
        SizedBox(height: TSize.spaceBetweenInputFields),
        TextFormField(
          controller: controller!.emailController,
          decoration: InputDecoration(
            prefixIcon: Icon(TIcon.email),
            labelText: 'Email',
          ),
          validator: TValidator.validateEmail,
        ),
        SizedBox(height: TSize.spaceBetweenInputFields),
        Form(
          key: controller!.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller!.nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(TIcon.person),
                  labelText: 'Name',
                ),
                validator: TValidator.validateTextField,
              ),
              SizedBox(height: TSize.spaceBetweenInputFields),
              CDatePicker(
                controller: controller!.dateController,
                labelText: 'Date of birth',
                hintText: controller!.datePattern,
                datePattern: controller!.datePattern,
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
                value: controller!.gender.isEmpty ? null : controller!.gender,
                onChanged: controller!.onGenderChange,
                hint: Text("Gender"),
                validator: TValidator.validateTextField,
              )
            ],
          ),
        ),
        SizedBox(height: TSize.spaceBetweenSections),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!widget.isEdit) ...[
              MainButton(
                onPressed: controller!.handleContinue,
                text: "Continue",
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              MainButton(
                onPressed: controller!.handleSkip,
                text: "Skip",
                isElevatedButton: false,
              ),
            ] else ...[
              MainButton(
                onPressed: controller!.handleContinue,
                text: "Save",
              ),
              SizedBox(height: TSize.spaceBetweenSections),
            ]
          ],
        ),
      ],
    );
  }
}
