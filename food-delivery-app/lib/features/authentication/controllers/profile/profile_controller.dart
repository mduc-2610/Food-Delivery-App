import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/token_service.dart';
import 'package:food_delivery_app/features/authentication/controllers/login/auth_controller.dart';
import 'package:food_delivery_app/features/authentication/models/account/profile.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
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
  DateTime? selectedDate;

  final String? userId;
  bool isEdit = false;

  ProfileController({
    this.userId,
    this.isEdit = false,
  });

  @override
  void onInit() async {
    super.onInit();
    if(isEdit) {
      final user = await APIService<User>()
          .retrieve(userId ?? "fad06fbd-72f0-4f05-a6e0-609296184c4d");
      final profile = await APIService<UserProfile>()
          .retrieve(userId ?? "fad06fbd-72f0-4f05-a6e0-609296184c4d");
      phoneNumber.value = PhoneNumber(dialCode: '+84', phoneNumber: user.phoneNumber, isoCode: "VN");
      $print(phoneNumber);
      emailController.text = user.email ?? "";
      nameController.text = profile.name ?? "";
      selectedDate = profile.dateOfBirth;
      $print(profile);
      gender = profile.gender?.toLowerCase() ?? "";
      dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
    }
    else {
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

  void handleContinue() async {
    if (formKey.currentState?.validate() ?? false) {
      final profileData = UserProfile(
          name: nameController.text,
          dateOfBirth: selectedDate,
          gender: gender.toUpperCase()
      );

      final [statusCode, headers, body] = await APIService<UserProfile>()
          .update(userId ?? authController?.user.id, profileData);
      await TokenService.saveToken(authController!.token);
      Get.offAll(() => UserMenuRedirection());
    }
  }

  void handleSkip() async {
    await TokenService.saveToken(authController!.token);
    Get.offAll(() => UserMenuRedirection());
  }

  void handleAddImage() {

  }
}
