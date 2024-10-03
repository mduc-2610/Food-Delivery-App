import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/basic_info.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_first_step_controller.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegistrationBasicInfoController extends GetxController {
  static RegistrationBasicInfoController get instance => Get.find();

  final formKey = GlobalKey<FormState>();

  final registrationFirstStepController = RegistrationFirstStepController.instance;
  User? user;
  Deliverer? deliverer;
  DelivererBasicInfo? basicInfo;

  final fullNameController = TextEditingController();
  final givenNameController = TextEditingController();
  final gender = ''.obs;
  final dateOfBirth = DateTime.now().obs;
  final hometown = ''.obs;
  final city = ''.obs;
  final district = ''.obs;
  final ward = ''.obs;
  final addressController = TextEditingController();
  final citizenIdentificationController = TextEditingController();
  final dateController = TextEditingController();

  final List<String> genderOptions = ["Male", "Female"];

  final RxList<String> hometownOptions = <String>[].obs;
  final RxList<String> cityOptions = <String>[].obs;
  final RxList<String> districtOptions = <String>[].obs;
  final RxList<String> wardOptions = <String>[].obs;

  RegistrationBasicInfoController() {
    user = registrationFirstStepController.user;
    deliverer = registrationFirstStepController.deliverer;
    basicInfo = deliverer?.basicInfo;

    cityOptions.value = THardCode.getVietnamLocation().map<String>((city) => city["name"] as String).toList();

    if (basicInfo != null) {
      fullNameController.text = basicInfo?.fullName ?? '';
      givenNameController.text = basicInfo?.givenName ?? '';
      gender.value = basicInfo?.gender ?? '';
      dateOfBirth.value = basicInfo?.dateOfBirth ?? DateTime.now();
      dateController.text = DateFormat("dd/MM/yyyy").format(dateOfBirth.value);
      hometown.value = basicInfo?.hometown ?? '';
      city.value = basicInfo?.city ?? '';
      district.value = basicInfo?.district ?? '';
      ward.value = basicInfo?.ward ?? '';
      addressController.text = basicInfo?.address ?? '';
      citizenIdentificationController.text = basicInfo?.citizenIdentification ?? '';

      _updateDistrictOptions(city.value);

      _updateWardOptions(district.value);
    }
  }

  void setCity(String? selectedCity) {
    city.value = selectedCity ?? "";
    district.value = "";
    ward.value = "";
    districtOptions.clear();
    wardOptions.clear();
    _updateDistrictOptions(city.value);
  }

  void _updateDistrictOptions(String cityName) {
    final cityMap = THardCode.getVietnamLocation().firstWhere(
          (city) => city["name"] == cityName,
      orElse: () => {},
    );

    if (cityMap.isNotEmpty) {
      final districts = cityMap["districts"] as List<dynamic>;
      districtOptions.value = districts.map<String>((district) => district["name"] as String).toList();
    }
  }

  void setDistrict(String? selectedDistrict) {
    district.value = selectedDistrict ?? "";
    ward.value = "";
    wardOptions.clear();
    _updateWardOptions(district.value);
  }

  void _updateWardOptions(String districtName) {
    for (var city in THardCode.getVietnamLocation()) {
      for (var district in city["districts"]) {
        if (district["name"] == districtName) {
          final communes = district["communes"] as List<dynamic>;
          wardOptions.value = communes.map<String>((commune) => commune as String).toList();
          return;
        }
      }
    }
    wardOptions.clear();
  }

  void setHometown(String? value) => hometown.value = value ?? "";
  void setGender(String? value) => gender.value = value ?? "";
  void setBirthDate(DateTime? date) {
    dateOfBirth.value = date ?? DateTime.now();
    dateController.text = DateFormat("dd/MM/yyyy").format(dateOfBirth.value);
  }
  void setWard(String? value) => ward.value = value ?? "";

  Future<void> onCallApi() async {
    final basicInfoData = DelivererBasicInfo(
      fullName: fullNameController.text,
      givenName: givenNameController.text,
      gender: gender.value,
      dateOfBirth: dateOfBirth.value,
      hometown: hometown.value,
      city: city.value,
      district: district.value,
      ward: ward.value,
      address: addressController.text,
      citizenIdentification: citizenIdentificationController.text,
    );
    if (basicInfo != null) {
      final [statusCode, headers, data] = await APIService<DelivererBasicInfo>()
          .update(deliverer?.id ?? "", basicInfoData.toJson());
      $print([statusCode, headers, data]);
    } else {
      if (deliverer == null) {
        var [statusCode, headers, data] = await APIService<Deliverer>()
            .create({
          "user": user?.id
        });
        $print([statusCode, headers, data]);
        if (statusCode == 200 || statusCode == 201) {
          deliverer = data;
          registrationFirstStepController.deliverer = data;
        }
      }
      basicInfoData.deliverer = deliverer?.id;
      $print(basicInfoData.toJson());
      final [statusCode, headers, data] = await APIService<DelivererBasicInfo>()
          .create(basicInfoData.toJson());
      $print([statusCode, headers, data]);
    }
  }

  void onSave() async {
    if (formKey.currentState?.validate() ?? false) {
      await onCallApi();
      formKey.currentState?.save();
      Get.snackbar("Success", "Information saved successfully");
    }
  }

  void onContinue() async {
    $print("asd");
      registrationFirstStepController.setTab();
    if (formKey.currentState?.validate() ?? false) {
      await onCallApi();
      formKey.currentState?.save();
      print("Continuing with registration process...");
      // Add continue logic here
    }
  }
}
