import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:food_delivery_app/utils/objects/objects.dart';
import 'package:get/get.dart';

class RegistrationDetailInfoController extends GetxController {
  static RegistrationDetailInfoController get instance => Get.find();

  final formKey = GlobalKey<FormState>();

  final keywordController = TextEditingController();
  final descriptionController = TextEditingController();

  // Document controllers
  final avatarImageController = Get.put(RegistrationDocumentFieldController(), tag: "menuImage");
  final coverImageController = Get.put(RegistrationDocumentFieldController(), tag: "coverImage");
  final frontViewController = Get.put(RegistrationDocumentFieldController(), tag: "frontView");

  var isOpen = {
    'Chủ Nhật': true.obs,
    'Thứ 2': true.obs,
    'Thứ 3': false.obs,
    'Thứ 4': true.obs,
    'Thứ 5': true.obs,
    'Thứ 6': true.obs,
    'Thứ 7': true.obs,
  }.obs;

  var operatingHours = {
    'Chủ Nhật': TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 22, minute: 0)).obs,
    'Thứ 2': TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 22, minute: 0)).obs,
    'Thứ 3': TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 22, minute: 0)).obs,
    'Thứ 4': TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 22, minute: 0)).obs,
    'Thứ 5': TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 22, minute: 0)).obs,
    'Thứ 6': TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 22, minute: 0)).obs,
    'Thứ 7': TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 22, minute: 0)).obs,
  }.obs;

  @override
  void onClose() {
    keywordController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void setOperatingHours(String day, TimeOfDay start, TimeOfDay end) {
    operatingHours[day]?.value = TimeOfDayRange(start: start, end: end);
  }
}
