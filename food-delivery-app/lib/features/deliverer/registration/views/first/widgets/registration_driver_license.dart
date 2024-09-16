import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_document_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';

class RegistrationDriverLicense extends StatelessWidget {
  const RegistrationDriverLicense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          RegistrationDocumentField(
            label: "Giấy phép Lái xe (mặt trước)",
            onTapAdd: () {
            },
          ),
          RegistrationDocumentField(
            label: "Giấy phép Lái xe (mặt sau)",
            onTapAdd: () {
            },
          ),
          RegistrationDropdownField(
            label: "Dòng xe",
            items: ["Select", "Vehicle 1", "Vehicle 2"],
            onChanged: (value) {},
          ),
          RegistrationTextField(
            label: "Biển số xe",
            onChanged: (value) {},
          ),
          RegistrationDocumentField(
            label: "Chứng nhận đăng ký xe mô tô, gắn máy (mặt trước)",
            onTapAdd: () {
            },
          ),
          RegistrationDocumentField(
            label: "Chứng nhận đăng ký xe mô tô, gắn máy (mặt sau)",
            onTapAdd: () {
            },
          ),
        ],
      ),
    );
  }
}
