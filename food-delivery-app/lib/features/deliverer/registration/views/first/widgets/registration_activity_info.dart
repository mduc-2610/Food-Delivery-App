import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_type_option.dart';

class RegistrationActivityInfo extends StatefulWidget {
  @override
  _RegistrationActivityInfoState createState() => _RegistrationActivityInfoState();
}

class _RegistrationActivityInfoState extends State<RegistrationActivityInfo> {
  String selectedDriverType = 'Tài xế HUB';

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                RegistrationDropdownField(
                    label: 'Tỉnh/Thành phố hoạt động',
                    onChanged: (x) {},
                    items: [""]
                ),
                RegistrationTypeOption(
                  label: 'Loại hình hoạt động',
                  types: ['Tài xế HUB', 'Tài xế Part-time'],
                  selectedType: selectedDriverType,
                  onChanged: (newType) {
                    setState(() {
                      selectedDriverType = newType;
                    });
                  },
                ),
                RegistrationDropdownField(label: 'HUB', onChanged: (x) {}, items: [""]),
                RegistrationDropdownField(label: 'Khu vực hoạt động', onChanged: (x) {}, items: [""]),
                RegistrationDropdownField(label: 'Thời gian hoạt động', onChanged: (x) {}, items: [""]),
                SizedBox(height: 16),
                Text(
                  'Thêm khu vực hoạt động mong muốn (tối đa 3)',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      );
  }
}