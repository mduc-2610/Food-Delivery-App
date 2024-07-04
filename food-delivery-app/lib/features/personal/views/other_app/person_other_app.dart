import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/sliver_sized_box.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class PersonalOtherAppView extends StatelessWidget {
  const PersonalOtherAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Other Apps",
            iconList: [
              {
                "icon": Icons.more_horiz
              }
            ],
          ),
          SliverToBoxAdapter(
            child: MainWrapper(
              child: Text(
                "We provide many services on many platforms.",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: TColor.primary),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverSizedBox(height: TSize.spaceBetweenItemsVertical,),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: TDeviceUtil.getScreenWidth() * 0.05),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final List<String> svgAssets = [
                    TImage.twitterLogo,
                    TImage.facebookLogo,
                    TImage.messengerLogo,
                    TImage.discordLogo,
                    TImage.skypeLogo,
                    TImage.telegramLogo,
                    TImage.wechatLogo,
                    TImage.whatsappLogo,
                  ];

                  return SvgPicture.asset(svgAssets[index]);
                },
                childCount: 8,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: TSize.gridViewSpacing,
                mainAxisSpacing: TSize.gridViewSpacing,
              ),
            ),
          ),

          SliverSizedBox(height: TSize.spaceBetweenSections,)
        ],
      ),
    );
  }
}
