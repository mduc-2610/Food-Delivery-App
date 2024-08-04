import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/personal/controllers/profile/theme_controller.dart';
import 'package:food_delivery_app/features/personal/views/profile/widgets/personal_setting.dart';
import 'package:food_delivery_app/features/restaurant/personal/views/profile/widgets/profile_flexible_space_bar.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            expandedHeight: 250.0,
            flexibleSpace: ProfileFlexibleSpaceBar(),
            title: "My Profile",
            noLeading: true,
          ),

          SliverToBoxAdapter(
            child: MainWrapper(
              child: Column(
                children: [
                  PersonalSetting(),
                  SizedBox(height: TSize.spaceBetweenItemsVertical,),

                  MainButton(
                    onPressed: () {},
                    text: "Logout",
                    textColor: TColor.primary,
                    height: TSize.buttonHeight + 6,
                    paddingHorizontal: 0,
                    prefixIcon: Icons.logout,
                    prefixIconColor: TColor.primary,
                    backgroundColor: TColor.iconBgCancel,
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical,),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
