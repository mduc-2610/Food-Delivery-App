import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/text_with_size.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class PersonalAboutAppView extends StatelessWidget {
  const PersonalAboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(title: "About App"),
      body: MainWrapper(
        child: Stack(
          children: [
            Container(
              width: TDeviceUtil.getScreenWidth(),
              padding: EdgeInsets.only(top: TDeviceUtil.getScreenHeight() * 0.2),
              child: Column(
                children: [
                  Image.asset(
                    width: TDeviceUtil.getScreenWidth() * 0.5,
                    height: TDeviceUtil.getScreenHeight() * 0.2,
                    TImage.toggleLogo,
                  ),
                  Text(
                    'SPEEDY CHOW',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(color: TColor.primary, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical,),
                  Text(
                    'Version 2.1.0',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
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
                  MainButton(
                    onPressed: () {},
                    text: "Other Apps",
                  ),
                  SizedBox(height: TSize.spaceBetweenSections,),

                  Text(
                    "www.speedychow.com\nCopyright © 2024 David (Vuong Huu Thien).\nAll rights reserved.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
