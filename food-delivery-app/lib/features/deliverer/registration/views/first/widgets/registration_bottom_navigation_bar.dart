import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RegistrationBottomNavigationBar extends StatelessWidget {
  const RegistrationBottomNavigationBar({super.key});

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
                    onPressed: () {},
                    text: "Luu",
                    backgroundColor: TColor.secondary,
                    borderColor: TColor.secondary,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: MainButton(
                    onPressed: () {},
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
