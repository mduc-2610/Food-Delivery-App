import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/authentication/views/onboarding/onboarding.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  Rx<int> currentPageIndex = 0.obs;
  Rx<double> progress = 0.0.obs;
  late Timer _timer;
  final pageController = PageController();

  final int totalDuration = 150;
  final int delayed = 25;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: delayed), (timer) {
      progress.value += 0.05 / (totalDuration / delayed);
      if (progress.value >= 1 + 3 / 4) {
        Get.offAll(() => OnBoardingView());
        _timer.cancel();
      } else {
        _updateCurrentIndex();
      }
    });
  }

  void _updateCurrentIndex() {
    if (progress.value >= 1 + 1 / 3) {
      currentPageIndex.value = 3;
    } else if (progress.value >= 1) {
      currentPageIndex.value = 2;
    } else if (progress.value >= 1 / 10) {
      currentPageIndex.value = 1;
    } else {
      currentPageIndex.value = 0;
    }
    pageController.animateToPage(
      currentPageIndex.value,
      duration: Duration(microseconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
