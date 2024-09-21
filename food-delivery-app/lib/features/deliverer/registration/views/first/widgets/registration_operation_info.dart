import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_type_option.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_operation_info.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class RegistrationOperationInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationOperationInfoController());

    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Obx(() => RegistrationDropdownField(
                    label: 'Tỉnh/Thành phố hoạt động',
                    onChanged: controller.setSelectedCity,
                    value: controller.city.value,
                    items: ["Hà Nội", "TP.HCM", "Đà Nẵng"],
                  )),
                  Obx(() => RegistrationTypeOption(
                    label: 'Loại hình hoạt động',
                    types: ['Hub', 'Part-time'],
                    selectedType: controller.driverType.value,
                    onChanged: controller.setDriverType,
                  )),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),
                  Obx(() => RegistrationDropdownField(
                    label: 'HUB',
                    onChanged: controller.setSelectedHub,
                    value: controller.hub.value,
                    items: ["HUB 1", "HUB 2", "HUB 3"],
                  )),
                  Obx(() => RegistrationDropdownField(
                    label: 'Khu vực hoạt động',
                    onChanged: controller.setSelectedArea,
                    value: controller.area.value,
                    items: ["Khu vực 1", "Khu vực 2", "Khu vực 3"],
                  )),
                  Obx(() => RegistrationDropdownField(
                    label: 'Thời gian hoạt động',
                    onChanged: controller.setSelectedTime,
                    value: controller.time.value,
                    items: ["Sáng", "Chiều", "Tối"],
                  )),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),
                  Text(
                    'Thêm khu vực hoạt động mong muốn (tối đa 3)',
                    style: TextStyle(color: Colors.blue),
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
