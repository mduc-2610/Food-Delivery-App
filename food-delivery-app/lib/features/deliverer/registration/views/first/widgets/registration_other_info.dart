import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_document_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';

class RegistrationOtherInfo extends StatelessWidget {
  const RegistrationOtherInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          RegistrationDropdownField(
            label: "Nghề nghiệp",
            items: ["Nhân viên văn phòng", "Tài xế", "Kỹ sư"],
            onChanged: (value) {},
          ),
          RegistrationTextField(
            label: "Chi tiết",
            hintText: "Tập vụ",
            onChanged: (value) {},
          ),
          RegistrationDocumentField(
            label: "Lý lịch tư pháp",
            onTapAdd: () {},
          ),

        ],
      ),
    );
  }
}
