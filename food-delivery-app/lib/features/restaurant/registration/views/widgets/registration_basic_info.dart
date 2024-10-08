import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/category_controller.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/registration_basic_info.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/category_selection.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/category_selection_sheet.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/constants/variable.dart';
import 'package:get/get.dart';

class RegistrationBasicInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationBasicInfoController());
    final categoryController = CategoryController.instance;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RegistrationTextField(
                        label: 'Restaurant Name',
                        controller: controller.shopNameController,
                        validator: (value) => value!.isEmpty ? 'Please enter restaurant name' : null,
                      ),
                    ),
                    // SizedBox(width: 10),
                    // Expanded(
                    //   child: Obx(() => RegistrationDropdownField(
                    //     label: 'Type',
                    //     items: ["Type 1", "Type 2"],
                    //     value: controller.shopType.value,
                    //     onChanged: controller.setShopType,
                    //   )),
                    // ),
                    // SizedBox(width: 10),
                    // Expanded(
                    //   child: RegistrationTextField(
                    //     label: 'Street',
                    //     controller: controller.streetController,
                    //     validator: (value) => value!.isEmpty ? 'Please enter street' : null,
                    //   ),
                    // ),
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
                SizedBox(height: TSize.spaceBetweenItemsVertical),
            
                MainButton(
                  onPressed: controller.handleLocationAdd,
                  text: 'Choose location',
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                RegistrationTextField(
                  label: 'House Number and Street',
                  controller: controller.addressController,
                  hintText: "Choose your location above",
                  validator: (value) => value!.isEmpty ? 'Please enter house and street' : null,
                  enabled: false,
                  maxLines: 3,
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                CategorySelection()
            
              ],
            ),
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
