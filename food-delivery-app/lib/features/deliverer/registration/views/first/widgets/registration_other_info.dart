import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_document_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_other_info.dart';
import 'package:get/get.dart';

class RegistrationOtherInfo extends StatelessWidget {
  const RegistrationOtherInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationOtherInfoController());

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Obx(() => RegistrationDropdownField(
            label: "Occupation",
            items: ["Office Worker", "Driver", "Engineer"],
            onChanged: controller.setOccupation,
            value: controller.occupation.value,
          )),
          RegistrationTextField(
            label: "Details",
            hintText: "Part-time",
            controller: controller.detailsController,
          ),
          RegistrationDocumentField(
            label: "Criminal Record",
            controller: controller.judicialRecordController,
          ),
        ],
      ),
      bottomNavigationBar: RegistrationBottomNavigationBar(
        onSave: controller.onSave,
        onContinue: controller.onContinue,
      ),
    );
  }
}
