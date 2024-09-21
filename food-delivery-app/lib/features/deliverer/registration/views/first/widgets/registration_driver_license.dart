import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_document_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_driver_license.dart';
import 'package:get/get.dart';

class RegistrationDriverLicense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationDriverLicenseController());
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          RegistrationDocumentField(
            label: "Giấy phép Lái xe (mặt trước)",
            controller: controller.frontLicenseController,
          ),
          RegistrationDocumentField(
            label: "Giấy phép Lái xe (mặt sau)",
            controller: controller.backLicenseController,
          ),
          Obx(() => RegistrationDropdownField(
            label: "Dòng xe",
            items: ["Vehicle 1", "Vehicle 2"],
            value: controller.vehicleType.value,
            onChanged: controller.setVehicleType,
          )),
          RegistrationTextField(
            label: "Biển số xe",
            controller: controller.licensePlateController,
          ),
          RegistrationDocumentField(
            label: "Chứng nhận đăng ký xe mô tô, gắn máy (mặt trước)",
            controller: controller.frontRegistrationController,
          ),
          RegistrationDocumentField(
            label: "Chứng nhận đăng ký xe mô tô, gắn máy (mặt sau)",
            controller: controller.backRegistrationController,
          ),
        ],
      ),
      bottomNavigationBar: RegistrationBottomNavigationBar(
        onSave: controller.onSave,
        onContinue: controller.onContinue,
      ),
    );
  }
}