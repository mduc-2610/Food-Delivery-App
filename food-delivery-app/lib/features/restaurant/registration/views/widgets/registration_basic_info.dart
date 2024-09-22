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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: RegistrationTextField(
                      label: 'Shop Name',
                      controller: controller.shopNameController,
                      validator: (value) => value!.isEmpty ? 'Please enter shop name' : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Obx(() => RegistrationDropdownField(
                      label: 'Type',
                      items: ["Type 1", "Type 2"],
                      value: controller.shopType.value,
                      onChanged: controller.setShopType,
                    )),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: RegistrationTextField(
                      label: 'Street',
                      controller: controller.streetController,
                      validator: (value) => value!.isEmpty ? 'Please enter street' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              RegistrationTextField(
                label: 'Contact Phone',
                controller: controller.contactPhoneController,
                validator: (value) => value!.isEmpty ? 'Please enter contact phone' : null,
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              Obx(() => RegistrationDropdownField(
                label: 'City',
                items: ["City 1", "City 2"],
                value: controller.city.value,
                onChanged: controller.setCity,
              )),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              Obx(() => RegistrationDropdownField(
                label: 'District',
                items: ["District 1", "District 2"],
                value: controller.district.value,
                onChanged: controller.setDistrict,
              )),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              RegistrationTextField(
                label: 'House Number and Street',
                controller: controller.streetAddressController,
                validator: (value) => value!.isEmpty ? 'Please enter house and street' : null,
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              ElevatedButton(
                onPressed: () {},
                child: Text('Check on Map'),
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