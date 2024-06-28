import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:food_delivery_app/features/authentication/views/onboarding/widgets/onboarding.dart';
import 'package:food_delivery_app/features/authentication/views/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/theme/custom_themes/text_button_theme.dart';
import 'package:get/get.dart';

class OnBoardingView extends StatelessWidget {
  final OnBoardingController _controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller.pageController,
            onPageChanged: _controller.updatePageIndicator,
            children: [
              OnBoarding(
                image: TImage.onBoarding1,
                title: "Wide Selection",
                subTitle: "More than 400 restaurants nationwide.",
              ),
              OnBoarding(
                image: TImage.onBoarding2,
                title: "Fast Delivery",
                subTitle: "Receive goods after 10 minutes.",
              ),
              OnBoarding(
                image: TImage.onBoarding3,
                title: "Order Tracking",
                subTitle: "Track your orders in real-time.",
              ),
              OnBoarding(
                image: TImage.onBoarding4,
                title: "Special offers",
                subTitle: "Weekly deals and discounts.",
              ),
            ],
          ),
          Positioned(
            bottom: TDeviceUtil.getBottomNavigationBarHeight(),
            left: 0,
            right: 0,
            child: Column(
              children: [
                OnBoardingDotNavigation(),
                SizedBox(height: TSize.spaceBetweenItems,),
                Container(
                  height: 55,
                  width: TDeviceUtil.getScreenWidth() * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: ElevatedButton(
                    onPressed: _controller.nextPage,
                    child: Text(
                        "Next"
                    ),
                  ),
                ),
                SizedBox(height: TSize.spaceBetweenItems,),
                Container(
                  height: 55,
                  width: TDeviceUtil.getScreenWidth() * 0.9,
                  child: Obx(() => TextButton(
                    onPressed: _controller.skipPageOrLoginRedirect,
                    child: Text(
                        _controller.skipOrRedirectText.value
                    ),
                  )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
