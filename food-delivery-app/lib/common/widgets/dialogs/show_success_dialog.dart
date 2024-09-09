import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

Future<void> showSuccessDialog(
    BuildContext context, {
      String? image,
      String head = "",
      String title = "",
      String description = "",
      String accept = "Ok",
      VoidCallback? onAccept,
      bool barrierDismissible = true,
      bool canPop = true,
    }) async {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return PopScope(
        canPop: canPop,
        child: AlertDialog(
          content: Padding(
            padding: EdgeInsets.all(TSize.sm),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  head,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: TSize.spaceBetweenSections),

                if (image != null) ...[
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
                    onAccept?.call();
                    Get.back();
                  },
                  text: accept,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
