import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/menu_delivery.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/registration_tab_controller.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RegistrationMenuDeliveryController extends GetxController {
  static RegistrationMenuDeliveryController get instance => Get.find();

  final formKey = GlobalKey<FormState>();
  final registrationTabController = RegistrationTabController.instance;
  Restaurant? restaurant;
  RestaurantMenuDelivery? menuDelivery;

  late RegistrationDocumentFieldController menuImageController;

  RegistrationMenuDeliveryController() {
    restaurant = registrationTabController.restaurant;
    menuDelivery = restaurant?.menuDelivery;

    menuImageController = Get.put(RegistrationDocumentFieldController(
        databaseImages: [menuDelivery?.menuImage]
    ), tag: "menuImage");
  }

  Future<void> onCallApi() async {
    final menuDeliveryData = RestaurantMenuDelivery(
      restaurant: restaurant?.id,
      menuImage: menuImageController.selectedImages.isNotEmpty
          ? menuImageController.selectedImages[0]
          : null,
    );

    if (menuDelivery != null) {
      final [statusCode, headers, data] = await APIService<RestaurantMenuDelivery>(dio: Dio())
          .update(registrationTabController.restaurant?.id ?? "", menuDeliveryData, isFormData: true, patch: true);
      $print([statusCode, headers, data]);
    } else {
      if (restaurant == null) {
        var [statusCode, headers, data] = await APIService<Restaurant>()
            .create({"user": registrationTabController.user?.id});
        $print([statusCode, headers, data]);
        if (statusCode == 200 || statusCode == 201) {
          restaurant = data;
          registrationTabController.restaurant = data;
        }
      }
      menuDeliveryData.restaurant = restaurant?.id;
      final [statusCode, headers, data] = await APIService<RestaurantMenuDelivery>(dio: Dio())
          .create(menuDeliveryData, isFormData: true);
      print([statusCode, headers, data]);
    }
  }

  void onSave() async {
    await onCallApi();
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      print('Saving menu delivery details...');
      Get.snackbar("Success", "Information saved successfully");
    }
  }

  void onContinue() async {
    await onCallApi();
      formKey.currentState?.save();
      registrationTabController.setTab();
    if (formKey.currentState?.validate() ?? false) {
      print('Proceeding to the next step...');
    }
  }

  @override
  void onClose() {
    // No need to dispose of any controllers here as we're only using the menuImageController
    super.onClose();
  }
}