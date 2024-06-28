import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/text_with_size.dart';
import 'package:food_delivery_app/features/authentication/controllers/splash/splash_controller.dart';
import 'package:food_delivery_app/features/authentication/views/splash/widgets/splash_welcome.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';

class SplashDone extends StatelessWidget {
  final SplashController _controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: TColor.primary,
            width: TDeviceUtil.getScreenWidth(),
            padding: EdgeInsets.only(top: TDeviceUtil.getScreenHeight() * 0.2),
            child: Column(
              children: [
                Image(
                  width: TDeviceUtil.getScreenWidth() * 0.5,
                  height: TDeviceUtil.getScreenHeight() * 0.2,
                  image: AssetImage(TImage.logo),
                ),
                Text(
                  'SPEEDY CHOW',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: TSize.spaceBetweenItems,),
                Text(
                  'Version 2.1.0',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
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
