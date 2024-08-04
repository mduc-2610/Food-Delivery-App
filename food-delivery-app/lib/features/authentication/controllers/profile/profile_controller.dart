import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/token_service.dart';
import 'package:food_delivery_app/features/authentication/controllers/login/auth_controller.dart';
import 'package:food_delivery_app/features/authentication/models/account/profile.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  AuthController? authController;
  final formKey = GlobalKey<FormState>();
  Rx<PhoneNumber> phoneNumber = PhoneNumber().obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dateController = TextEditingController();
  String gender = "";
  String datePattern = "dd/MM/yyyy";
  
  String initialName = "";
  String initialEmail = "";
  String initialGender = "";
  String initialPhoneNumber = "";
  DateTime? initialDateOfBirth;

  User? user;
  bool isEdit = false;

  ProfileController({
    this.isEdit = false,
  });

  @override
  void onInit() async {
    super.onInit();
    if (isEdit) {
      final token = await TokenService.getToken();
      user = await APIService<Me>(token: token, pagination: false,).list();
      $print(user);
      final profile = await APIService<UserProfile>(token: token).retrieve(user?.id ?? "fad06fbd-72f0-4f05-a6e0-609296184c4d");
      phoneNumber.value = PhoneNumber(dialCode: '+84', phoneNumber: user?.phoneNumber, isoCode: "VN");
      emailController.text = user?.email ?? "";
      nameController.text = profile.name ?? "";
      gender = profile.gender?.toLowerCase() ?? "";
      dateController.text = DateFormat('dd/MM/yyyy').format(profile.dateOfBirth ?? DateTime.now());

      initialName = profile.name ?? "";
      initialEmail = user?.email ?? "";
      initialPhoneNumber = user?.phoneNumber ?? "";
      initialGender = profile.gender?.toLowerCase() ?? "";
      initialDateOfBirth = profile.dateOfBirth;
    } else {
      authController = AuthController.instance;
      phoneNumber.value = authController!.phoneNumber.value;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    dateController.dispose();
    super.onClose();
  }

  void onGenderChange(String? value) {
    gender = value ?? "";
  }

  bool hasProfileChanged() {
    return nameController.text != initialName ||
        emailController.text != initialEmail ||
        phoneNumber.value.phoneNumber != initialPhoneNumber ||
        gender != initialGender ||
        DateFormat('dd/MM/yyyy').parse(dateController.text) != initialDateOfBirth;
  }

  void handleContinue() async {
    if (formKey.currentState?.validate() ?? false) {
      final profileData = UserProfile(
        name: nameController.text,
        dateOfBirth: dateController.text,
        gender: gender.toUpperCase(),
      );
      $print(profileData);
      Token? token;
      if(isEdit) {
        token = await TokenService.getToken();
        $print(token);
      }

      final [statusCode, headers, body] = await APIService<UserProfile>(token: token)
          .update(user?.id ?? authController?.user.id ?? "fad06fbd-72f0-4f05-a6e0-609296184c4d", profileData);

      if (!isEdit) {
        await TokenService.saveToken(authController!.token);
        Get.offAll(() => UserMenuRedirection());
      } else {
        Get.back();
        if (hasProfileChanged()) {
          Get.back();
          THelperFunction.showCSnackBar(
            Get.context!,
            "Profile updated successfully",
            SnackBarType.success,
          );
        }
        // else {
        //   THelperFunction.showCSnackBar(
        //     Get.context!,
        //     "No changes detected",
        //     SnackBarType.info,
        //   );
        // }
      }
    }
  }

  void handleSkip() async {
    await TokenService.saveToken(authController!.token);
    Get.offAll(() => UserMenuRedirection());
  }

  void handleAddImage() {
    // Implement handleAddImage logic
  }
}
