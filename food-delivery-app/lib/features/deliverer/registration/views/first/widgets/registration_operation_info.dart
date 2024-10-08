import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_type_option.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_operation_info.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';
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
                    label: 'City of Operation',
                    onChanged: controller.setSelectedCity,
                    value: controller.city.value,
                    items: THardCode.getVietnamLocation().map((ele) => ele["name"] as String).toList(),
                  )),
                  Obx(() => RegistrationTypeOption(
                    label: 'Type of Operation',
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
                    label: 'Operational Area',
                    onChanged: controller.setSelectedArea,
                    value: controller.area.value,
                    items: ["Area 1", "Area 2", "Area 3"],
                  )),
                  Obx(() => RegistrationDropdownField(
                    label: 'Operational Time',
                    onChanged: controller.setSelectedTime,
                    value: controller.time.value,
                    items: ["Morning", "Afternoon", "Evening"],
                  )),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),
                  Text(
                    'Add desired operational areas (up to 3)',
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
