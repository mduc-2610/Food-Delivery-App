import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_document_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_type_option.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RegistrationMenuDelivery extends StatefulWidget {
  @override
  State<RegistrationMenuDelivery> createState() => _RegistrationMenuDeliveryState();
}

class _RegistrationMenuDeliveryState extends State<RegistrationMenuDelivery> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(TSize.spaceBetweenItemsVertical),
        child: ListView(
          children: [
            RegistrationDocumentField(
              label: "Anh chup menu",
              onTapAdd: () {
              },
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
          ],
        ),
      ),
    );
  }
}
