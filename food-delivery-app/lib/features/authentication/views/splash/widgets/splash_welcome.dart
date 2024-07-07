import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/text_with_size.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class SplashWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(TImage.welcomeBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  "Welcome to",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "SPEEDY CHOW",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
