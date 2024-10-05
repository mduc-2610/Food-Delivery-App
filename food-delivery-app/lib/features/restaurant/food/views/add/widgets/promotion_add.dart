import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/bottom_bar_wrapper.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_date_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/features/deliverer/registration/views/skeleton/registration_skeleton.dart';
import 'package:food_delivery_app/features/restaurant/food/controllers/add/promotion_add_controller.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class PromotionAddView extends StatelessWidget {
  final String? promotionId;

  const PromotionAddView({
    this.promotionId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PromotionAddController(promotionId: promotionId));
    return Scaffold(
      body: Obx(() => (controller.isLoading.value == true)
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
            RegistrationTextField(
              label: "Promotion Code",
              hintText: "Enter promotion code",
              controller: controller.codeController,
            ),
            RegistrationTextField(
              label: "Name",
              hintText: "Enter promotion name",
              controller: controller.nameController,
            ),
            RegistrationTextField(
              label: "Description",
              hintText: "Enter a description",
              controller: controller.descriptionController,
              maxLines: 5,
              maxLength: 500,
            ),
            Obx(() => RegistrationDropdownField(
              label: "Promotion Type",
              items: ["Shipping", "Order"],
              onChanged: controller.setPromoType,
              value: controller.promoType.value,
            )),
            RegistrationTextField(
              label: "Discount Amount",
              hintText: "Enter discount amount",
              controller: controller.discountAmountController,
              keyboardType: TextInputType.number,
            ),
            RegistrationTextField(
              label: "Discount Percentage",
              hintText: "Enter discount percentage",
              controller: controller.discountPercentageController,
              keyboardType: TextInputType.number,
            ),
            Obx(() => RegistrationDateField(
              label: 'Start Date',
              hintText: "dd/MM/yyyy",
              selectedDate: controller.startDate.value,
              onDateSelected: controller.setStartDate,
              controller: controller.startDateController,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please select your date of birth';
              //   }
              //   return null;
              // },
            )),
            Obx(() => RegistrationDateField(
              label: 'End Date',
              hintText: "dd/MM/yyyy",
              selectedDate: controller.endDate.value,
              onDateSelected: controller.setEndDate,
              controller: controller.endDateController,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please select your date of birth';
              //   }
              //   return null;
              // },
            )),
          ],
        ),
      ),
      ),
      bottomNavigationBar: BottomBarWrapper(
        child: MainWrapper(
          child: MainButton(
            text: 'Save Promotion',
            onPressed: controller.onSave,
          ),
        ),
      ),
    );
  }
}