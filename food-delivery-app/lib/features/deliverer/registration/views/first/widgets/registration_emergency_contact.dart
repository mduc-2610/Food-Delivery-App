import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_emergency_contact.dart';
import 'package:get/get.dart';

class RegistrationEmergencyContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationEmergencyContactController());

    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RegistrationTextField(
                hintText: "Nguyen Thi B",
                label: 'Name',
                controller: controller.nameController,
              ),
              SizedBox(height: 16),
              RegistrationTextField(
                hintText: "Spouse",
                label: 'Relationship',
                controller: controller.relationshipController,
              ),
              SizedBox(height: 16),
              RegistrationTextField(
                hintText: "+84858189821",
                label: 'Phone Number',
                controller: controller.phoneController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: RegistrationBottomNavigationBar(
        onSave: controller.onSave,
        onContinue: controller.onContinue,
      ),
    );
  }
}
