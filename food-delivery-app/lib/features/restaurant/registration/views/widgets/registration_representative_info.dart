import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_document_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_type_option.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RegistrationRepresentativeInfo extends StatefulWidget {
  @override
  State<RegistrationRepresentativeInfo> createState() => _RegistrationRepresentativeInfoState();
}

class _RegistrationRepresentativeInfoState extends State<RegistrationRepresentativeInfo> {
  String selectedRegister = "Cá nhân";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(TSize.spaceBetweenItemsVertical),
        child: ListView(
          children: [
            RegistrationTypeOption(
              label: 'Đăng ký dưới danh nghĩa:',
              types: ['Cá nhân', 'Công ty/Chuỗi'],
              selectedType: selectedRegister,
              onChanged: (newType) {
                setState(() {
                  selectedRegister = newType;
                });
              },
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationTextField(label: 'Tên đầy đủ người đại diện', onChanged: (x) {},),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationTextField(label: 'Email', onChanged: (x) {},),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationTextField(label: 'Số điện thoại', onChanged: (x) {},),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationTextField(label: 'Số CMND', onChanged: (x) {},),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationDocumentField(
              label: "Ảnh chụp mặt trước CMND",
              onTapAdd: () {
              },
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationDocumentField(
              label: "Ảnh chụp mặt sau CMND",
              onTapAdd: () {
              },
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationDocumentField(
              label: "Dang ky kinh doanh",
              onTapAdd: () {
              },
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            RegistrationTextField(label: 'Ma so thue', onChanged: (x) {},),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
          ],
        ),
      ),
    );
  }
}
