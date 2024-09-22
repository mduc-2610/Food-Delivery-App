import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/registration_payment.dart';
import 'package:get/get.dart';

class RegistrationPaymentInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationPaymentInfoController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            RegistrationTextField(
              label: 'Email to Access NowMerchant Wallet',
              controller: controller.emailController,
              hintText: 'Enter email',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            RegistrationTextField(
              label: 'Phone Number to Access NowMerchant Wallet',
              controller: controller.phoneController,
              hintText: 'Enter phone number',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            RegistrationTextField(
              label: 'Citizen ID Number',
              controller: controller.citizenIdentificationController,
              hintText: 'Enter citizen ID number',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            RegistrationTextField(
              label: 'Bank Account Holder Name',
              controller: controller.accountNameController,
              hintText: 'Enter account holder name',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            RegistrationTextField(
              label: 'Bank Account Number',
              controller: controller.accountNumberController,
              hintText: 'Enter account number',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            Obx(() => RegistrationDropdownField(
              label: 'Bank Name',
              items: [
                'Vietcombank (Foreign Trade Bank of Vietnam)',
                'Vietinbank (Vietnam Industrial and Commercial Bank)',
                'BIDV (Bank for Investment and Development of Vietnam)',
              ],
              value: controller.bank.value,
              onChanged: controller.setBank,
            )),
            SizedBox(height: 16),
            Obx(() => RegistrationDropdownField(
              label: 'City/Province of Branch',
              items: [
                'Hanoi',
                'Ho Chi Minh City',
                'Da Nang',
                'Can Tho',
              ],
              value: controller.city.value,
              onChanged: controller.setCity,
            )),
            SizedBox(height: 16),
            Obx(() => RegistrationDropdownField(
              label: 'Bank Branch',
              items: [
                'Branch A',
                'Branch B',
                'Branch C',
              ],
              value: controller.branch.value,
              onChanged: controller.setBranch,
            )),
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
