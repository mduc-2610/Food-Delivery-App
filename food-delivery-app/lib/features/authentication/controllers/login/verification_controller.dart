import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  VerificationController get instance => Get.find();

  var timer = 45.obs;
  var isCodeSent = false.obs;
  final int timerDuration;
  late Timer _countdownTimer;
  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  VerificationController({this.timerDuration = 45}) {
    focusNodes = List.generate(4, (index) => FocusNode());
    controllers = List.generate(4, (index) => TextEditingController());
  }

  void startTimer() {
    timer.value = timerDuration;
    isCodeSent.value = true;

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.timer.value == 0) {
        stopTimer();
        isCodeSent.value = false;
      } else {
        this.timer.value--;
      }
    });
  }

  void stopTimer() {
    _countdownTimer.cancel();
  }

  void handleInputChange(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 3) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
      }
    }
  }

  @override
  void onClose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
