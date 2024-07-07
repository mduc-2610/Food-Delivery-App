import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class PersonalInviteView extends StatelessWidget {
  const PersonalInviteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Invite friends",
            iconList: [
              {
                "icon": Icons.more_horiz
              }
            ],
          ),

          SliverToBoxAdapter(
            child: MainWrapper(
              child: SizedBox(
                height: TDeviceUtil.getScreenHeight() - TDeviceUtil.getAppBarHeight() * 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 14 / 16,
                      shrinkWrap: true,
                      children: [
                        SvgPicture.asset(TImage.twitterLogo),
                        SvgPicture.asset(TImage.facebookLogo),
                        SvgPicture.asset(TImage.messengerLogo),
                        SvgPicture.asset(TImage.discordLogo),
                        SvgPicture.asset(TImage.skypeLogo),
                        SvgPicture.asset(TImage.telegramLogo),
                        SvgPicture.asset(TImage.wechatLogo),
                        SvgPicture.asset(TImage.whatsappLogo),
                      ],
                    ),
                  ],
                ),
              )
            )
          )
        ],
      ),
    );
  }
}
