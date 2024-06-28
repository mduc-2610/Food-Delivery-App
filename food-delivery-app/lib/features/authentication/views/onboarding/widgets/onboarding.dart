import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/authentication/views/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class OnBoarding extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;

  const OnBoarding({
    required this.image,
    required this.title,
    required this.subTitle,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          width: TDeviceUtil.getScreenWidth() ,
          height: TDeviceUtil.getScreenHeight() * 0.6,
          image: AssetImage(
            image,
          ),
        ),
        Column(
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: TColor.primary),
                ),
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: TColor.primary),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
