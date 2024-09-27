import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_date_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_basic_info.dart';
import 'package:get/get.dart';

class RegistrationBasicInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationBasicInfoController(), tag: "deliverer");

    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  RegistrationTextField(
                    hintText: "Nguyễn Văn",
                    label: 'Full Name',
                    controller: controller.fullNameController,
                  ),
                  RegistrationTextField(
                    hintText: "A",
                    label: 'Given Name',
                    controller: controller.givenNameController,
                  ),
                  Obx(() => RegistrationDropdownField(
                    label: 'Gender',
                    onChanged: controller.setGender,
                    value: controller.gender.value,
                    items: ["Male", "Female"],
                  )),
                  Obx(() => RegistrationDateField(
                    hintText: "Please select a date",
                    label: 'Date of Birth',
                    selectedDate: controller.dateOfBirth.value,
                    onDateSelected: controller.setBirthDate,
                    controller: controller.dateController,
                  )),
                  Obx(() => RegistrationDropdownField(
                    label: 'Hometown',
                    onChanged: controller.setHometown,
                    value: controller.hometown.value,
                    items: ["Hà Nội", "TP.HCM", "Đà Nẵng"],
                  )),
                  Obx(() => RegistrationDropdownField(
                    label: 'City of Residence (on ID card)',
                    onChanged: controller.setResidentCity,
                    value: controller.city.value,
                    items: ["Hà Nội", "TP.HCM", "Đà Nẵng"],
                  )),
                  Obx(() => RegistrationDropdownField(
                    label: 'District of Residence (on ID card)',
                    onChanged: controller.setResidentDistrict,
                    value: controller.district.value,
                    items: ["Quận 1", "Quận 2", "Quận 3"],
                  )),
                  Obx(() => RegistrationDropdownField(
                    label: 'Ward of Residence (on ID card)',
                    onChanged: controller.setResidentWard,
                    value: controller.ward.value,
                    items: ["Phường 1", "Phường 2", "Phường 3"],
                  )),
                  RegistrationTextField(
                    hintText: "0 / 255",
                    label: "Address of Residence (on ID card)",
                    controller: controller.addressController,
                  ),
                  RegistrationTextField(
                    hintText: "Enter",
                    label: "Citizen Identification Number (ID card)",
                    controller: controller.citizenIdentificationController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: RegistrationBottomNavigationBar(
        onSave: controller.onSave,
        onContinue: controller.onContinue,
      ),
    );
  }
}
