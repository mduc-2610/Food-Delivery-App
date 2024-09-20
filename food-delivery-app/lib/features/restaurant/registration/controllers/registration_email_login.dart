import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class RegistrationEmailLogin extends StatefulWidget {
  @override
  State<RegistrationEmailLogin> createState() => _RegistrationEmailLoginState();
}

class _RegistrationEmailLoginState extends State<RegistrationEmailLogin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(TSize.spaceBetweenItemsVertical),
        child: ListView(
          children: [
            RegistrationTextField(label: 'Email', controller: TextEditingController(),),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
          ],
        ),
      ),
      bottomNavigationBar: RegistrationBottomNavigationBar(
          onSave: () {},
          onContinue: () {}
      ),
    );
  }
}
