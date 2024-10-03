import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/detail_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/registration_tab_controller.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:food_delivery_app/utils/objects/objects.dart';
import 'package:get/get.dart';

class RegistrationDetailInfoController extends GetxController {
  static RegistrationDetailInfoController get instance => Get.find();

  final formKey = GlobalKey<FormState>();
  final registrationTabController = RegistrationTabController.instance;
  Restaurant? restaurant;
  RestaurantDetailInfo? detailInfo;

  final keywordController = TextEditingController();
  final descriptionController = TextEditingController();
  final restaurantTypeController = TextEditingController();
  final cuisineController = TextEditingController();
  final specialtyDishesController = TextEditingController();
  final servingTimesController = TextEditingController();
  final targetAudienceController = TextEditingController();
  final purposeController = TextEditingController();

  late RegistrationDocumentFieldController avatarImageController;
  late RegistrationDocumentFieldController coverImageController;
  late RegistrationDocumentFieldController facadeImageController;

  var operatingHours = {
    'Monday': [TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 17, minute: 0))].obs,
    'Tuesday': [TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 17, minute: 0))].obs,
    'Wednesday': [TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 17, minute: 0))].obs,
    'Thursday': [TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 17, minute: 0))].obs,
    'Friday': [TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 17, minute: 0))].obs,
    'Saturday': <TimeOfDayRange>[].obs,
    'Sunday': <TimeOfDayRange>[].obs,
  }.obs;

  RegistrationDetailInfoController() {
    restaurant = registrationTabController.restaurant;
    detailInfo = restaurant?.detailInfo;

    if (detailInfo != null) {
      keywordController.text = detailInfo?.keywords ?? '';
      descriptionController.text = detailInfo?.description ?? '';
      restaurantTypeController.text = detailInfo?.restaurantType ?? '';
      cuisineController.text = detailInfo?.cuisine ?? '';
      specialtyDishesController.text = detailInfo?.specialtyDishes ?? '';
      servingTimesController.text = detailInfo?.servingTimes ?? '';
      targetAudienceController.text = detailInfo?.targetAudience ?? '';
      purposeController.text = detailInfo?.purpose ?? '';

      if (detailInfo?.operatingHours != null) {
        Map<String, dynamic>? hours = detailInfo?.operatingHours;
        hours?.forEach((day, periods) {
          operatingHours[day] = (periods as List).map((period) =>
              TimeOfDayRange(
                  start: _parseTimeOfDay(period['open']),
                  end: _parseTimeOfDay(period['close'])
              )
          ).toList().obs;
        });
      }
    }

    avatarImageController = Get.put(RegistrationDocumentFieldController(
        databaseImages: [detailInfo?.avatarImage]
    ), tag: "avatarImage");

    coverImageController = Get.put(RegistrationDocumentFieldController(
        databaseImages: [detailInfo?.coverImage]
    ), tag: "coverImage");

    facadeImageController = Get.put(RegistrationDocumentFieldController(
        databaseImages: [detailInfo?.facadeImage]
    ), tag: "facadeImage");
  }

  TimeOfDay _parseTimeOfDay(String time) {
    List<String> parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  void setOperatingHours(String day, List<TimeOfDayRange> ranges) {
    operatingHours[day] = ranges.obs;
  }

  Future<void> onCallApi() async {
    $print("THIS operating hours: $operatingHours");
    final detailInfoData = RestaurantDetailInfo(
      keywords: keywordController.text,
      description: descriptionController.text,
      avatarImage: avatarImageController.selectedImages.isNotEmpty ? avatarImageController.selectedImages[0] : null,
      coverImage: coverImageController.selectedImages.isNotEmpty ? coverImageController.selectedImages[0] : null,
      facadeImage: facadeImageController.selectedImages.isNotEmpty ? facadeImageController.selectedImages[0] : null,
      restaurantType: restaurantTypeController.text,
      cuisine: cuisineController.text,
      specialtyDishes: specialtyDishesController.text,
      servingTimes: servingTimesController.text,
      targetAudience: targetAudienceController.text,
      purpose: purposeController.text,
      operatingHours: operatingHours,
    );

    if (restaurant != null && detailInfo != null) {
      final [statusCode, headers, data] = await APIService<RestaurantDetailInfo>(dio: Dio())
          .update(restaurant?.id ?? "", detailInfoData, isFormData: true, patch: true);
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
      detailInfoData.restaurant = restaurant?.id;
      print(detailInfoData.toJson());
      final [statusCode, headers, data] = await APIService<RestaurantDetailInfo>(dio: Dio())
          .create(detailInfoData, isFormData: true);
      print([statusCode, headers, data]);
    }
  }

  void onSave() async {
    await onCallApi();
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      print('Saving Detail Info');
      Get.snackbar("Success", "Information saved successfully");
    }
  }

  void onContinue() async {
    await onCallApi();
      formKey.currentState?.save();
      registrationTabController.setTab();
    if (formKey.currentState?.validate() ?? false) {
      print('Continuing to next step');
    }
  }

  void toggleOperatingHours(String day, bool value) {
    if (value) {
      setOperatingHours(day, [TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 17, minute: 0))]);
    } else {
      setOperatingHours(day, []);
    }
    $print("Operating hours: $operatingHours");
  }

  Future<void> updateOperatingHours(String day, bool isStartTime) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: isStartTime
          ? operatingHours[day]!.first.start
          : operatingHours[day]!.first.end,
    );
    if (pickedTime != null) {
      List<TimeOfDayRange> newRanges = [...operatingHours[day]!];
      TimeOfDayRange currentRange = newRanges[0];

      if (isStartTime) {
        if (pickedTime.hour > currentRange.end.hour ||
            (pickedTime.hour == currentRange.end.hour && pickedTime.minute >= currentRange.end.minute)) {
          Get.snackbar(
            'Invalid Time',
            'Start time must be earlier than end time.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.yellow,
          );
          return;
        }
        newRanges[0] = TimeOfDayRange(start: pickedTime, end: currentRange.end);
      } else {
        if (pickedTime.hour < currentRange.start.hour ||
            (pickedTime.hour == currentRange.start.hour && pickedTime.minute <= currentRange.start.minute)) {
          Get.snackbar(
            'Invalid Time',
            'End time must be later than start time.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.yellow,
          );
          return;
        }
        newRanges[0] = TimeOfDayRange(start: currentRange.start, end: pickedTime);
      }
      setOperatingHours(day, newRanges);
    }
  }

  @override
  void onClose() {
    keywordController.dispose();
    descriptionController.dispose();
    restaurantTypeController.dispose();
    cuisineController.dispose();
    specialtyDishesController.dispose();
    servingTimesController.dispose();
    targetAudienceController.dispose();
    purposeController.dispose();
    super.onClose();
  }
}