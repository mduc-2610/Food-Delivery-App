import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  final OnBoardingController _controller = OnBoardingController.instance;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      effect: ExpandingDotsEffect(activeDotColor: TColor.primary, dotHeight: 6),
      controller: _controller.pageController,
      onDotClicked: _controller.dotNavigationClick,
      count: 4,
    );
  }
}
