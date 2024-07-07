import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

void showSuccessDialog(
    BuildContext context,
    {
      String? image,
      String head = "",
      String title = "",
      String description = "",
      String accept = "Ok",
    }
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Padding(
          padding:  EdgeInsets.all(TSize.sm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                head,
                style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
              ),
              SizedBox(height: TSize.spaceBetweenSections),

              if(image != null)...[
                Image.asset(
                  image,
                  width: TSize.imageDialogSize,
                ),
                SizedBox(height: TSize.spaceBetweenSections),
              ],

              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              Text(
                description,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              MainButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: accept,
              )
            ],
          ),
        ),
      );
    },
  );
}