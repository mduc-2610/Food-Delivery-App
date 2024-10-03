import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/residency_info.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_first_step_controller.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegistrationResidencyInfoController extends GetxController {
  static RegistrationResidencyInfoController get instance => Get.find();

  final formKey = GlobalKey<FormState>();

  final registrationFirstStepController = RegistrationFirstStepController.instance;
  Deliverer? deliverer;
  DelivererResidencyInfo? residencyInfo;

  final isSameAsCI = true.obs;
  final hasTaxNumber = false.obs;
  final city = ''.obs;
  final district = ''.obs;
  final ward = ''.obs;
  final addressController = TextEditingController();
  final taxNumberController = TextEditingController();
  final emailController = TextEditingController();

  final List<String> taxNumberOptions = ["Yes", "No"];

  final RxList<String> cityOptions = <String>[].obs;
  final RxList<String> districtOptions = <String>[].obs;
  final RxList<String> wardOptions = <String>[].obs;

  RegistrationResidencyInfoController() {
    deliverer = registrationFirstStepController.deliverer;
    residencyInfo = deliverer?.residencyInfo;

    cityOptions.value = THardCode.getVietnamLocation().map<String>((city) => city["name"] as String).toList();

    if (residencyInfo != null) {
      isSameAsCI.value = residencyInfo?.isSameAsCI ?? true;
      city.value = residencyInfo?.city ?? '';
      district.value = residencyInfo?.district ?? '';
      ward.value = residencyInfo?.ward ?? '';
      addressController.text = residencyInfo?.address ?? '';
      taxNumberController.text = residencyInfo?.taxCode ?? '';
      hasTaxNumber.value = residencyInfo?.taxCode?.isNotEmpty ?? false;
      emailController.text = residencyInfo?.email ?? '';

      _updateDistrictOptions(city.value);

      _updateWardOptions(district.value);
    }
  }

  void toggleIsSameAsCI(bool value) {
    isSameAsCI.value = value;
  }

  void toggleHasTaxNumber(bool value) {
    hasTaxNumber.value = value;
    if (!value) {
      taxNumberController.text = "";
    }
  }

  void setResidentCity(String? selectedCity) {
    city.value = selectedCity ?? "";
    district.value = "";
    ward.value = "";
    districtOptions.clear();
    wardOptions.clear();
    _updateDistrictOptions(city.value);
  }

  void setResidentDistrict(String? selectedDistrict) {
    district.value = selectedDistrict ?? "";
    ward.value = "";
    wardOptions.clear();
    _updateWardOptions(district.value);
  }

  void setResidentWard(String? selectedWard) {
    ward.value = selectedWard ?? "";
  }

  void _updateDistrictOptions(String cityName) {
    final cityMap = THardCode.getVietnamLocation().firstWhere(
          (city) => city["name"] == cityName,
      orElse: () => {},
    );

    if (cityMap.isNotEmpty) {
      final districts = cityMap["districts"] as List<dynamic>;
      districtOptions.value = districts.map<String>((district) => district["name"] as String).toList();
    } else {
      districtOptions.clear();
    }
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

  Future<void> onCallApi() async {
    final residencyInfoData = DelivererResidencyInfo(
      isSameAsCI: isSameAsCI.value,
      email: emailController.text,
      city: city.value,
      district: district.value,
      ward: ward.value,
      address: addressController.text,
      taxCode: hasTaxNumber.value ? taxNumberController.text : null,
    );

    print(residencyInfoData.toJson());

    if (residencyInfo != null) {
      final [statusCode, headers, data] = await APIService<DelivererResidencyInfo>()
          .update(deliverer?.id ?? "", residencyInfoData.toJson());
      print([statusCode, headers, data]);
    } else {
      if (deliverer == null) {
        var [statusCode, headers, data] = await APIService<Deliverer>()
            .create({"user": registrationFirstStepController.user?.id});
        print([statusCode, headers, data]);
        if (statusCode == 200 || statusCode == 201) {
          deliverer = data;
          registrationFirstStepController.deliverer = data;
        }
      }
      residencyInfoData.deliverer = deliverer?.id;
      final [statusCode, headers, data] = await APIService<DelivererResidencyInfo>()
          .create(residencyInfoData.toJson());
      print([statusCode, headers, data]);
    }
  }

  void onSave() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await onCallApi();
      Get.snackbar("Success", "Residency Information saved successfully");
      print("Saved Residency Information");
    }
  }

  void onContinue() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await onCallApi();
      registrationFirstStepController.setTab();
      print("Continuing to next step");
    }
  }

  @override
  void onClose() {
    addressController.dispose();
    taxNumberController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
