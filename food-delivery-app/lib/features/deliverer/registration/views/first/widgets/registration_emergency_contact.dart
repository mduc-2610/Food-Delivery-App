import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';

class RegistrationEmergencyContact extends StatefulWidget {
  @override
  _RegistrationEmergencyContactState createState() => _RegistrationEmergencyContactState();
}

class _RegistrationEmergencyContactState extends State<RegistrationEmergencyContact> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RegistrationTextField(
              hintText: "Nguyen Thi B",
              label: 'Tên',
              onChanged: (x) {},
            ),
            SizedBox(height: 16),
            RegistrationTextField(
              hintText: "Vo chong",
              label: 'Mối quan hệ',
              onChanged: (x) {},
            ),
            SizedBox(height: 16),
            RegistrationTextField(
              hintText: "+84858189821",
              label: 'Số điện thoại',
              onChanged: (x) {},
            ),

          ],
        ),
      ),
    );
  }
}