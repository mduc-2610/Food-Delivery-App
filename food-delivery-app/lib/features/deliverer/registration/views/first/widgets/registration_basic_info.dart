import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/fields/date_picker.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_date_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_basic_info.dart';
import 'package:food_delivery_app/utils/validators/validators.dart';
import 'package:get/get.dart';

class RegistrationBasicInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationBasicInfoController());

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
                    label: 'Họ và tên đệm',
                    controller: controller.fullName,
                  ),
                  RegistrationTextField(
                    hintText: "A",
                    label: 'Tên',
                    controller: controller.givenName,
                  ),
                  Obx(() => RegistrationDropdownField(
                    label: 'Giới tính',
                    onChanged: controller.setGender,
                    value: controller.gender.value,
                    items: ["Nam", "Nữ", "Khác"],
                  )),
                  Obx(() => RegistrationDateField(
                    hintText: "Vui lòng chọn ngày",
                    label: 'Ngày sinh',
                    selectedDate: controller.birthDate.value,
                    onDateSelected: controller.setBirthDate,
                    controller: controller.dateController,
                  )),

                  Obx(() => RegistrationDropdownField(
                    label: 'Quê quán',
                    onChanged: controller.setHometown,
                    value: controller.hometown.value,
                    items: ["Hà Nội", "TP.HCM", "Đà Nẵng"],
                  )),
                  Obx(() => RegistrationDropdownField(
                    label: 'Tỉnh/Thành phố thường trú (trên CCCD)',
                    onChanged: controller.setResidentCity,
                    value: controller.residentCity.value,
                    items: ["Hà Nội", "TP.HCM", "Đà Nẵng"],
                  )),
                  Obx(() => RegistrationDropdownField(
                    label: 'Quận/Huyện thường trú (trên CCCD)',
                    onChanged: controller.setResidentDistrict,
                    value: controller.residentDistrict.value,
                    items: ["Quận 1", "Quận 2", "Quận 3"],
                  )),
                  Obx(() => RegistrationDropdownField(
                    label: 'Phường/Xã thường trú (trên CCCD)',
                    onChanged: controller.setResidentWard,
                    value: controller.residentWard.value,
                    items: ["Phường 1", "Phường 2", "Phường 3"],
                  )),
                  RegistrationTextField(
                    hintText: "0 / 255",
                    label: "Địa chỉ thường trú (trên CCCD)",
                    controller: controller.address,
                  ),
                  RegistrationTextField(
                    hintText: "Nhập",
                    label: "Số Căn cước công dân (CCCD)",
                    controller: controller.idNumber,
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
