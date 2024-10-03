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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your given name';
                      }
                      return null;
                    },
                  ),
                  Obx(() => RegistrationDropdownField(
                    label: 'Gender',
                    onChanged: controller.setGender,
                    value: controller.gender.value.isEmpty ? null : controller.gender.value,
                    items: controller.genderOptions,
                  )),
                  Obx(() => RegistrationDateField(
                    hintText: "Please select a date",
                    label: 'Date of Birth',
                    selectedDate: controller.dateOfBirth.value,
                    onDateSelected: controller.setBirthDate,
                    controller: controller.dateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your date of birth';
                      }
                      return null;
                    },
                  )),
                  // Obx(() => RegistrationDropdownField(
                  //   label: 'Hometown',
                  //   onChanged: controller.setHometown,
                  //   value: controller.hometown.value.isEmpty ? null : controller.hometown.value,
                  //   items: controller.cityOptions,
                  // )),
                  Obx(() => RegistrationDropdownField(
                    label: 'City of Residence (on ID card)',
                    onChanged: controller.setCity,
                    value: controller.city.value.isEmpty ? null : controller.city.value,
                    items: controller.cityOptions,
                  )),
                  Obx(() => RegistrationDropdownField(
                    label: 'District of Residence (on ID card)',
                    onChanged: controller.setDistrict,
                    value: controller.district.value.isEmpty ? null : controller.district.value,
                    items: controller.districtOptions.isEmpty
                        ? ["Select a city first"]
                        : controller.districtOptions,
                  )),
                  Obx(() => RegistrationDropdownField(
                    label: 'Ward of Residence (on ID card)',
                    onChanged: controller.setWard,
                    value: controller.ward.value.isEmpty ? null : controller.ward.value,
                    items: controller.wardOptions.isEmpty
                        ? ["Select a district first"]
                        : controller.wardOptions,
                  )),
                  Obx(() => RegistrationDropdownField(
                    label: 'Hometown',
                    onChanged: controller.setHometown,
                    value: controller.hometown.value.isEmpty ? null : controller.hometown.value,
                    items: controller.wardOptions.isEmpty
                        ? ["Select a district first"]
                        : controller.wardOptions,
                  )),
                  RegistrationTextField(
                    hintText: "0 / 255",
                    label: "Address of Residence (on ID card)",
                    controller: controller.addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  RegistrationTextField(
                    hintText: "Enter",
                    label: "Citizen Identification Number (ID card)",
                    controller: controller.citizenIdentificationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your ID card number';
                      }
                      return null;
                    },
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
