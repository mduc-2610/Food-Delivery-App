import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

void openLoadingDialog(String text, String animation) {
  showDialog(
    context: Get.overlayContext!,
    barrierDismissible:  false,
    builder: (_) => PopScope(
      canPop: false,
      child: Container(
        color: THelperFunction.isDarkMode(Get.context!) ? TColor.dark : TColor.light,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 250,),

          ]
        ),
      ),
    )
  );
}