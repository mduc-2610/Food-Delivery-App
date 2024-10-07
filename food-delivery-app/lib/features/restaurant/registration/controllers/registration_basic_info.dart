import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/basic_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/category_controller.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/registration_tab_controller.dart';
import 'package:food_delivery_app/features/user/order/models/custom_location.dart';
import 'package:food_delivery_app/features/user/order/views/location/location_add.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RegistrationBasicInfoController extends GetxController {
  static RegistrationBasicInfoController get instance => Get.find();

  final formKey = GlobalKey<FormState>();
  final registrationTabController = RegistrationTabController.instance;
  Restaurant? restaurant;
  late final CategoryController categoryController;
  RestaurantBasicInfo? basicInfo;

  final shopNameController = TextEditingController();
  final streetController = TextEditingController();
  final contactPhoneController = TextEditingController();
  final addressController = TextEditingController();
  final shopType = ''.obs;
  final city = ''.obs;
  final district = ''.obs;
  BaseLocation? chosenLocation;

  final RxList<String> hometownOptions = <String>[].obs;
  final RxList<String> cityOptions = <String>[].obs;
  final RxList<String> districtOptions = <String>[].obs;
  final RxList<String> wardOptions = <String>[].obs;

  RegistrationBasicInfoController() {
    restaurant = registrationTabController.restaurant;
    categoryController =  Get.put(CategoryController(restaurant: restaurant));
    basicInfo = restaurant?.basicInfo;
    cityOptions.value = THardCode.getVietnamLocation().map<String>((city) => city["name"] as String).toList();

    if (basicInfo != null) {
      shopNameController.text = basicInfo?.name ?? '';


      addressController.text = basicInfo?.address ?? '';
      contactPhoneController.text = basicInfo?.phoneNumber ?? '';
      city.value = basicInfo?.city ?? '';
      district.value = basicInfo?.district ?? '';

      chosenLocation = BaseLocation(
        latitude: basicInfo?.latitude,
        longitude: basicInfo?.longitude,
        address: addressController.text,
        name: basicInfo?.addressName,
      );
      $print("Address name: ${basicInfo?.addressName}");
    }
    _updateDistrictOptions(city.value);
  }

  void setShopType(String? value) => shopType.value = value ?? '';
  void setCity(String? selectedCity) {
    city.value = selectedCity ?? "";
    district.value = "";
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
  }

  Future<void> onCallApi() async {
    $print("onCallAPI $chosenLocation");
    final basicInfoData = RestaurantBasicInfo(
      name: shopNameController.text,
      phoneNumber: contactPhoneController.text,
      city: city.value,
      district: district.value,
      address: addressController.text,
      addressName: chosenLocation?.name,
      latitude: chosenLocation?.latitude,
      longitude: chosenLocation?.longitude,
    );

    if (basicInfo != null) {
      final [statusCode, headers, data] = await APIService<RestaurantBasicInfo>()
          .update(registrationTabController.restaurant?.id ?? "", basicInfoData, patch: true);
      print([statusCode, headers, data]);
    } else {
      if (restaurant == null) {
        var [statusCode, headers, data] = await APIService<Restaurant>()
            .create({"user": registrationTabController.user?.id});
        print([statusCode, headers, data]);
        if (statusCode == 200 || statusCode == 201) {
          restaurant = data;
          registrationTabController.restaurant = data;
        }
      }
      basicInfoData.restaurant = restaurant?.id;
      final [statusCode, headers, data] = await APIService<RestaurantBasicInfo>()
          .create(basicInfoData);
      print([statusCode, headers, data]);
    }
    try {
      final restaurantData = {
        "categories": categoryController.selectedCategories.map((category) => category.id).toList(),
        "disabled_categories": categoryController.disabledCategories.map((category) => category.id).toList(),
      };
      $print(restaurantData);
      final [statusCode, headers, data] = await APIService<Restaurant>().update(
          registrationTabController.restaurant?.id, restaurantData,);
      if (statusCode == 200 || statusCode == 201) {
        restaurant = data;
        registrationTabController.restaurant = data;
      }
    }
    catch(e) {
      registrationTabController.restaurant = await APIService<Restaurant>().retrieve(registrationTabController.restaurant?.id ?? '');
      restaurant = registrationTabController.restaurant;
    }
  }

  void onSave() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await onCallApi();
      print('Saving Basic Info');
      Get.snackbar("Success", "Information saved successfully");
    }
  }

  void handleLocationAdd() async {
    final result = await Get.to(() => LocationAddView(
      initLocation: chosenLocation,
    )) as Map<String, dynamic>?;
    if(result != null) {
      var tmp = BaseLocation.fromJson(result);
      // chosenLocation?.latitude = tmp.latitude ?? chosenLocation?.latitude;
      // chosenLocation?.longitude = tmp.longitude ?? chosenLocation?.longitude;
      chosenLocation?.name = tmp.name;
      chosenLocation?.address = tmp.address;
      addressController.text = chosenLocation?.address ?? "";

      $print("DATA: $result $chosenLocation");
    }
  }

  void onContinue() async {
    await onCallApi();
    registrationTabController.setTab();
      formKey.currentState?.save();
    if (formKey.currentState?.validate() ?? false) {
      print('Continuing to next step');
    }
  }

  @override
  void onClose() {
    shopNameController.dispose();
    streetController.dispose();
    contactPhoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}