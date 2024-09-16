import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_date_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';

class RegistrationBasicInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              RegistrationTextField(
                hintText: "Nguyễn Văn",
                label: 'Họ và tên đệm', onChanged: (x) {},
              ),
              RegistrationTextField(
                hintText: "A",
                label: 'Tên', onChanged: (x) {},
              ),
              RegistrationDropdownField(
                label: 'Giới tính', onChanged: (x) {}, items: [""],
              ),
              RegistrationDateField(
                hintText: "Vui lòng chọn ngày",
                label: 'Ngày sinh', onDateSelected: (x) {},
              ),
              RegistrationDropdownField(
                label: 'Quê quán', onChanged: (x) {}, items: [""],
              ),
              RegistrationDropdownField(
                label: 'Tỉnh/Thành phố thường trú (trên CCCD)', onChanged: (x) {}, items: [""],
              ),
              RegistrationDropdownField(
                label: 'Quận/Huyện thường trú (trên CCCD)', onChanged: (x) {}, items: [""],
              ),
              RegistrationDropdownField(
                label: 'Phường/Xã thường trú (trên CCCD)', onChanged: (x) {}, items: [""],
              ),
              RegistrationTextField(
                  hintText: "0 / 255",
                  label: "Địa chỉ thường trú (trên CCCD)", onChanged: (x) {}
              ),
              RegistrationTextField(
                  hintText: "Nhập",
                  label: "Số Căn cước công dân (CCCD)", onChanged: (x) {}
              ),
            ],
          ),
        ),
      ],
    );
  }
}