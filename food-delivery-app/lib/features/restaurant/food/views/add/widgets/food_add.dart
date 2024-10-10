import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/bottom_bar_wrapper.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_document_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/skeleton/skeleton_list.dart';
import 'package:food_delivery_app/features/deliverer/registration/views/skeleton/registration_skeleton.dart';
import 'package:food_delivery_app/features/restaurant/food/controllers/add/food_add_controller.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';
import 'dart:io';

class FoodAddView extends StatelessWidget {
  final String? dishId;

  const FoodAddView({
    this.dishId
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodAddController(dishId: dishId));
    return Scaffold(
      // appBar: CAppBar(
      //   title: "Add New Dish",
      // ),
      body:
      Obx(() => (controller.isLoading.value == true)
          ? MainWrapper(
            topMargin: TSize.spaceBetweenItemsVertical,
            child: SingleChildScrollView(
              child: Column(
                      children: List.generate(10, (_) => RegistrationSkeletonField(label: "")),
                    ),
            ),
          )
          : Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            RegistrationDocumentField(
              label: "Upload image",
              controller: controller.imageController,
              buttonWidth: TDeviceUtil.getScreenWidth(),
              imageWidth: TDeviceUtil.getScreenWidth(),
              imageHeight: 300,
            ),
            RegistrationDocumentField(
              label: "Upload extra image",
              controller: controller.imagesController,
            ),

            RegistrationTextField(
              label: "Dish Name",
              hintText: "Enter dish name",
              controller: controller.nameController,
            ),
            RegistrationTextField(
              label: "Description",
              hintText: "Enter a description",
              controller: controller.descriptionController,
              maxLines: 5,
              maxLength: 500,
            ),
            RegistrationTextField(
              label: "Original Price",
              hintText: "Enter original price",
              controller: controller.originalPriceController,
              keyboardType: TextInputType.number,
            ),
            RegistrationTextField(
              label: "Discount Price",
              hintText: "Enter discount price (optional)",
              controller: controller.discountPriceController,
              keyboardType: TextInputType.number,
            ),
            Obx(() => RegistrationDropdownField(
              label: "Category",
              // items: ["Starter", "Main Course", "Dessert"],
              items: controller.restaurant?.categories.map((category) => category.name ?? '').toList() ?? [],
              onChanged: controller.setCategory,
              value: controller.category.value,
            )),
            // Obx(() => RegistrationDropdownField(
            //   label: "Restaurant",
            //   items: ["Restaurant A", "Restaurant B", "Restaurant C"],
            //   onChanged: controller.setRestaurant,
            //   value: controller.restaurant.value,
            // )),
            SizedBox(height: 10),

          ],
        ),
      ),),
      bottomNavigationBar: BottomBarWrapper(
        child: MainWrapper(
          child: MainButton(
            text: 'Save Dish',
            onPressed: controller.onSave,
          ),
        ),
      )
    );
  }
}