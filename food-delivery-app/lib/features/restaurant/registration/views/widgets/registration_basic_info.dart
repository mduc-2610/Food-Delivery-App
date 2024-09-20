import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/registration_basic_info.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class RegistrationBasicInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationBasicInfoController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: RegistrationTextField(
                      label: 'Tên quán',
                      controller: controller.shopNameController,
                      validator: (value) => value!.isEmpty ? 'Please enter shop name' : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Obx(() => RegistrationDropdownField(
                      label: 'Loại',
                      items: ["", "Type 1", "Type 2"],
                      value: controller.shopType.value,
                      onChanged: controller.setShopType,
                    )),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: RegistrationTextField(
                      label: 'Đường/phố',
                      controller: controller.streetController,
                      validator: (value) => value!.isEmpty ? 'Please enter street' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              RegistrationTextField(
                label: 'Số điện thoại liên hệ',
                controller: controller.contactPhoneController,
                validator: (value) => value!.isEmpty ? 'Please enter contact phone' : null,
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              Obx(() => RegistrationDropdownField(
                label: 'Thành phố',
                items: ["", "City 1", "City 2"],
                value: controller.city.value,
                onChanged: controller.setCity,
              )),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              Obx(() => RegistrationDropdownField(
                label: 'Quận',
                items: ["", "District 1", "District 2"],
                value: controller.district.value,
                onChanged: controller.setDistrict,
              )),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              RegistrationTextField(
                label: 'Số nhà và Đường/Phố',
                controller: controller.houseStreetController,
                validator: (value) => value!.isEmpty ? 'Please enter house and street' : null,
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              ElevatedButton(
                onPressed: () {
                },
                child: Text('Kiểm tra trên bản đồ'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: RegistrationBottomNavigationBar(
        onSave: controller.onSave,
        onContinue: controller.onContinue,
      ),
    );
  }
}
