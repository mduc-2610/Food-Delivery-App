import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/authentication/views/splash/widgets/splash_welcome.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:food_delivery_app/features/authentication/views/splash/widgets/splash_done.dart';
import 'package:food_delivery_app/features/authentication/views/splash/widgets/splash_middle.dart';
import 'package:food_delivery_app/features/authentication/views/splash/widgets/splash_start.dart';

class SplashController extends GetxController {
  var currentIndex = 0.obs;
  var progress = 0.0.obs;
  late Timer _timer;

  final int totalDuration = 1;
  final int delayed = 75;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: totalDuration), (timer) {
      progress.value += 0.05 / (totalDuration * delayed);
      if (progress.value >= 2) {
        Get.offAll(() => Placeholder());
        _timer.cancel();
      } else if (progress.value >= 1 + 1 / 2) {
        currentIndex.value = 3;
      } else if (progress.value >= 1) {
        currentIndex.value = 2;
      } else if (progress.value >= 1 / 5) {
        currentIndex.value = 1;
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
