import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/registration_payment.dart';
import 'package:get/get.dart';

class RegistrationPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationPaymentController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            RegistrationTextField(
              label: 'Email truy cập ví NowMerchant Wallet',
              controller: controller.emailController,
              hintText: 'Nhập email',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            RegistrationTextField(
              label: 'SĐT truy cập ví NowMerchant Wallet',
              controller: controller.phoneController,
              hintText: 'Nhập số điện thoại',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            RegistrationTextField(
              label: 'Số CMND',
              controller: controller.idController,
              hintText: 'Nhập số CMND',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            RegistrationTextField(
              label: 'Tên chủ tài khoản ngân hàng',
              controller: controller.accountNameController,
              hintText: 'Nhập tên tài khoản',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            RegistrationTextField(
              label: 'Số tài khoản ngân hàng',
              controller: controller.accountNumberController,
              hintText: 'Nhập số tài khoản',
              maxLines: 1,
            ),
            SizedBox(height: 16),
            Obx(() => RegistrationDropdownField(
              label: 'Tên ngân hàng',
              items: [
                'NH Ngoại thương Viet Nam (Vietcombank)',
                'NH Công thương Viet Nam (Vietinbank)',
                'NH Đầu tư và Phát triển Viet Nam (BIDV)',
              ],
              value: controller.selectedBank.value,
              onChanged: (String? value) {
                controller.selectedBank.value = value!;
              },
            )),
            SizedBox(height: 16),
            Obx(() => RegistrationDropdownField(
              label: 'Tỉnh/Thành phố của chi nhánh',
              items: [
                'Hà Nội',
                'TP. Hồ Chí Minh',
                'Đà Nẵng',
                'Cần Thơ',
              ],
              value: controller.selectedCity.value,
              onChanged: (String? value) {
                controller.selectedCity.value = value;
              },
            )),
            SizedBox(height: 16),
            Obx(() => RegistrationDropdownField(
              label: 'Chi nhánh ngân hàng',
              items: [
                'Chi nhánh A',
                'Chi nhánh B',
                'Chi nhánh C',
              ],
              value: controller.selectedBranch.value,
              onChanged: (String? value) {
                controller.selectedBranch.value = value;
              },
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
