import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/skip_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RatingBottom extends StatelessWidget {
  final String text1, text2;
  final VoidCallback skipOnPressed;
  final VoidCallback submitOnPressed;

  const RatingBottom({
    this.text1 = "Skip",
    this.text2 = "Submit",
    required this.skipOnPressed,
    required this.submitOnPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      bottomMargin: TSize.spaceBetweenSections,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SkipButton(
              onPressed: skipOnPressed,
              text: text1,
            ),
          ),
          SizedBox(width: TSize.spaceBetweenItemsHorizontal,),
          Expanded(child: ElevatedButton(
            onPressed: submitOnPressed,
            child: Text(text2),
          ),)
        ],
      ),
    );
  }
}
