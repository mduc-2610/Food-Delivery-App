import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RegistrationBottomNavigationBar extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onContinue;

  const RegistrationBottomNavigationBar({
    required this.onSave,
    required this.onContinue,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MainWrapper(
        child: Column(
          children: [
            SizedBox(height: TSize.spaceBetweenItemsVertical,),
            Row(
              children: [
                Expanded(
                  child: MainButton(
                    onPressed: onSave,
                    text: "Luu",
                    backgroundColor: TColor.secondary,
                    borderColor: TColor.secondary,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: MainButton(
                    onPressed: onContinue,
                    text: "Tiep theo",
                  ),
                )
              ],
            ),
            SizedBox(height: TSize.spaceBetweenSections,)
          ],
        ),
      ),
    );
  }
}
