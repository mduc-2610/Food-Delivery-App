// splash_view.dart
import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/authentication/controllers/splash/splash_controller.dart';
import 'package:food_delivery_app/features/authentication/views/splash/widgets/splash_done.dart';
import 'package:food_delivery_app/features/authentication/views/splash/widgets/splash_middle.dart';
import 'package:food_delivery_app/features/authentication/views/splash/widgets/splash_start.dart';
import 'package:food_delivery_app/features/authentication/views/splash/widgets/splash_welcome.dart';
import 'package:food_delivery_app/utils/theme/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashView extends StatelessWidget {
  final SplashController _controller = Get.put(SplashController());

  Widget _getCurrentView(int index) {
    switch (index) {
      case 0:
        return SplashStart();
      case 1:
        return SplashMiddle();
      case 2:
        return SplashDone();
      case 3:
        return SplashWelcome();
      default:
        return SplashStart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: TAppTheme.darkTheme,
      child: Scaffold(
        body: Stack(
          children: [
            Obx(() => _getCurrentView(_controller.currentIndex.value)),
          ],
        ),
      ),
    );
  }
}
