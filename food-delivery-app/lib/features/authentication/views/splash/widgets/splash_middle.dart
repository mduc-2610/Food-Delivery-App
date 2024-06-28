import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/text_with_size.dart';
import 'package:food_delivery_app/features/authentication/controllers/splash/splash_controller.dart';
import 'package:food_delivery_app/features/authentication/views/splash/widgets/splash_done.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class SplashMiddle extends StatelessWidget {
  final SplashController _controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: TColor.primary,
            child: Column(
              children: [
                Center(
                  child: Image(
                    width: TDeviceUtil.getScreenWidth() * 0.5,
                    height: TDeviceUtil.getScreenHeight() * 0.85,
                    image: AssetImage(TImage.logo),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                TextWithSize(
                  aspectScreenWidth: 0.8,
                  text: "As fast as lightning, as delicious as thunder!",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: TSize.spaceBetweenSections,),
                Obx(() => LinearProgressIndicator(
                  value: _controller.progress.value,
                  backgroundColor: Colors.white,
                  color: Colors.orange[900],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
