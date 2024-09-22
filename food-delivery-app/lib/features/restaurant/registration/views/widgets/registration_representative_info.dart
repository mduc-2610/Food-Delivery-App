import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_document_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_type_option.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/registration_representative_info.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RegistrationRepresentativeInfo extends StatefulWidget {
  @override
  State<RegistrationRepresentativeInfo> createState() => _RegistrationRepresentativeInfoState();
}

class _RegistrationRepresentativeInfoState extends State<RegistrationRepresentativeInfo> {
  final controller = Get.put(RegistrationRepresentativeInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(TSize.spaceBetweenItemsVertical),
        child: ListView(
          children: [
            Obx(() => RegistrationTypeOption(
                label: 'Register as:',
                types: ['Individual', 'Restaurant Chain'],
                selectedType: controller.registrationType.value,
                onChanged: controller.setRegistrationType
            )),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationTextField(
              label: 'Full Name of Representative',
              controller: controller.fullNameController,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationTextField(
              label: 'Email',
              controller: controller.emailController,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationTextField(
              label: 'Phone Number',
              controller: controller.phoneController,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationTextField(
              label: 'Alternate Phone Number',
              controller: controller.otherPhoneController,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationTextField(
              label: 'Citizen ID Number',
              controller: controller.citizenIdentificationController,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationDocumentField(
              label: "Citizen ID Front Image",
              controller: controller.citizenIdentificationFrontController,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationDocumentField(
              label: "Citizen ID Back Image",
              controller: controller.citizenIdentificationBackController,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationDocumentField(
              label: "Business Registration",
              controller: controller.businessRegistrationImageController,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationTextField(
              label: 'Tax Code',
              controller: controller.taxCodeController,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
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
