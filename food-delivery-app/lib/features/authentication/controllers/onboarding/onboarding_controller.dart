import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/authentication/views/login/login.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  Rx<String> skipOrRedirectText = "Skip".obs;
  Rx<int> currentPageIndex = 0.obs;
  final pageController = PageController();

  void updatePageIndicator(index) {
    currentPageIndex.value = index;
    if (currentPageIndex.value == 3) {
      skipOrRedirectText.value = "Login / Registration";
    }
    else {
      skipOrRedirectText.value = "Skip";
    }
  }

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  void nextPage() {
    if(currentPageIndex.value == 3) {
      Get.to(() => LoginView());
    }
    else {
      currentPageIndex.value += 1;
      pageController.jumpToPage(currentPageIndex.value);
    }
  }

  void skipPageOrLoginRedirect() {
    if (currentPageIndex.value == 3) {
      Get.offAll(() => LoginView());
    } else {
      currentPageIndex.value = 3;
      pageController.jumpToPage(3);
      updatePageIndicator(3);
    }
  }
}