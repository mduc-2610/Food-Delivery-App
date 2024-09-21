import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_document_field.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/registration_menu_delivery.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RegistrationMenuDelivery extends StatefulWidget {
  @override
  State<RegistrationMenuDelivery> createState() => _RegistrationMenuDeliveryState();
}

class _RegistrationMenuDeliveryState extends State<RegistrationMenuDelivery> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationMenuDeliveryController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(TSize.spaceBetweenItemsVertical),
        child: ListView(
          children: [
            RegistrationDocumentField(
              label: "Ảnh chụp menu",
              controller: controller.menuImageController,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
          ],
        ),
      ),
      bottomNavigationBar: RegistrationBottomNavigationBar(
        onSave: controller.onSave,
        onContinue: controller.onContinue,
      ),
    );
  }
}
