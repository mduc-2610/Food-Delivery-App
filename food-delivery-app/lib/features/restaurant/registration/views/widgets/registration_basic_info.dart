import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RegistrationBasicInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Tên quán
            Row(
              children: [
                Expanded(child: RegistrationTextField(label: 'Tên quán', onChanged: (x) {},)),
                SizedBox(width: 10),
                Expanded(child: RegistrationDropdownField(label: 'Loại', onChanged: (x) {}, items: [""])),
                SizedBox(width: 10),
                Expanded(child: RegistrationTextField(label: 'Đường/phố', onChanged: (x) {},)),
              ],),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationTextField(label: 'Số điện thoại liên hệ', onChanged: (x) {},),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationDropdownField(label: 'Thành phố', onChanged: (x) {}, items: [""],),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationDropdownField(label: 'Quận', onChanged: (x) {}, items: [""],),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationTextField(label: 'Số nhà và Đường/Phố', onChanged: (x) {},),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            ElevatedButton(
              onPressed: () {
              },
              child: Text('Kiểm tra trên bản đồ'),
              style: ElevatedButton.styleFrom(),
            ),
          ],
        ),
      ),
    );
  }
}