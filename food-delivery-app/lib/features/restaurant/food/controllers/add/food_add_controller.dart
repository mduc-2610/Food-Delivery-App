import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:food_delivery_app/data/services/restaurant_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/restaurant/food/controllers/manage/food_manage_controller.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FoodAddController extends GetxController {
  static FoodAddController get instance => Get.find();

  final formKey = GlobalKey<FormState>();
  String? dishId;
  Dish? dish;

  Rx<bool> isLoading = true.obs;
  Restaurant? restaurant;
  List<String> categories = [];
  Map<String, String> mapCategories = {};

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final originalPriceController = TextEditingController();
  final discountPriceController = TextEditingController();
  final originalPrice = 0.0.obs;
  final discountPrice = 0.0.obs;
  final category = ''.obs;
  late RegistrationDocumentFieldController imageController;
  late RegistrationDocumentFieldController imagesController;

  FoodAddController({ this.dishId });

  void assignDishData() {
    if (dish != null) {
      nameController.text = dish?.name ?? '';
      descriptionController.text = dish?.description ?? '';
      originalPriceController.text = dish?.originalPrice.toString() ?? '';
      discountPriceController.text = dish?.discountPrice.toString() ?? '';

      originalPrice.value = dish?.originalPrice ?? 0.0;
      discountPrice.value = dish?.discountPrice ?? 0.0;
      category.value = dish?.category?.name ?? '';
    }

    originalPriceController.addListener(() => setOriginalPrice(originalPriceController.text));
    discountPriceController.addListener(() => setDiscountPrice(discountPriceController.text));

    imageController = Get.put(
        RegistrationDocumentFieldController(databaseImages: [dish?.image]),
        tag: "dishImage"
    );
    imagesController = Get.put(
        RegistrationDocumentFieldController(
            databaseImages: dish?.images.map((image) => image.image ?? '').toList() ?? [],
            maxLength: 6
        ),
        tag: "dishImages"
    );
    $print(dish?.images.map((image) => image.image ?? '').toList() ?? []);
  }

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null) {
      dishId = Get.arguments['id'];
    }
    initialize();
  }

  Future<void> initialize() async {
    isLoading.value = true;
    restaurant = restaurant ?? await RestaurantService.getRestaurant();
    if(dishId != null) {
      dish = await APIService<Dish>().retrieve(dishId ?? '');
    }
    assignDishData();
    for (var _category in restaurant?.categories ?? []) {
      mapCategories[_category.name] = _category.id;
      categories.add(_category.name ?? '');
    }
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();
  }

  void setOriginalPrice(String? value) => originalPrice.value = THelperFunction.formatDouble(value);
  void setDiscountPrice(String? value) => discountPrice.value = THelperFunction.formatDouble(value);
  void setCategory(String? value) => category.value = value ?? '';

  Future<void> onCallApi() async {
    final dishData = Dish(
      name: nameController.text,
      description: descriptionController.text,
      originalPrice: originalPrice.value,
      discountPrice: discountPrice.value,
      category: mapCategories[category.value],
      image: imageController.selectedImages.isNotEmpty ? imageController.selectedImages[0] : null,
      images: imagesController.selectedImages,
      restaurant: restaurant?.id,
    );

    if (dish != null) {
      final [statusCode, headers, data] = await APIService<Dish>(dio: Dio())
          .update(dish?.id ?? "", dishData, isFormData: true,);
      $print([statusCode, headers, data]);
    } else {
      final [statusCode, headers, data] = await APIService<Dish>(dio: Dio())
          .create(dishData, isFormData: true);
      $print([statusCode, headers, data]);
    }
  }

  void onSave() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await onCallApi();
      var __controller;
      try {
        __controller = FoodManageController.instance;
      }
      catch(e) {
      }
      Get.back(result: true);
      await __controller?.initialize();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    originalPriceController.dispose();
    discountPriceController.dispose();
    super.onClose();
  }
}
