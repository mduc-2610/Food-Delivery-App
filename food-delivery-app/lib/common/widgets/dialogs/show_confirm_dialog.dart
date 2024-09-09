import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

void showConfirmDialog(
    BuildContext context, {
      VoidCallback? onDecline,
      VoidCallback? onAccept,
      String? accept,
      String? decline,
      String? title,
      String? description,
      String? imagePath,
      TextStyle? titleTextStyle,
      TextStyle? descriptionTextStyle,
      Color? acceptButtonColor,
      Color? declineButtonColor,
    }) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          '${title ?? ''}',
          style: titleTextStyle ?? Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath ?? TImage.diaClover,
              height: 100,
              width: 100,
            ),
            SizedBox(height: 16),
            Text(
              '${description ?? ''}',
              style: descriptionTextStyle, // Apply custom or default text style
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            children: [
              Expanded(
                child: SmallButton(
                  backgroundColor: declineButtonColor ?? TColor.reject,
                  text: '${decline ?? 'No'}',
                  onPressed: () {
                    Navigator.of(context).pop();
                    onDecline?.call();
                  },
                ),
              ),
              SizedBox(width: TSize.spaceBetweenItemsHorizontal),
              Expanded(
                child: SmallButton(
                  backgroundColor: acceptButtonColor ?? TColor.success,
                  text: '${accept ?? 'Yes'}',
                  onPressed: () {
                    Navigator.of(context).pop();
                    onAccept?.call();
                  },
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
