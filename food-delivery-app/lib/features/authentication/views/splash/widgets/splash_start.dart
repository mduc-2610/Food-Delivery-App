import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/authentication/controllers/splash/splash_controller.dart';
import 'package:food_delivery_app/features/authentication/views/splash/widgets/splash_middle.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:get/get.dart';

class SplashStart extends StatelessWidget {
  final SplashController _controller = SplashController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: TColor.primary,
        child: Stack(
          children: [
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Obx(() => LinearProgressIndicator(
                value: _controller.progress.value,
              )),
            ),
          ],
        )
      ),
    );
  }
}
