import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/restaurant/personal/views/profile/widgets/profile_flexible_space_bar.dart';
import 'package:food_delivery_app/features/user/personal/controllers/profile/theme_controller.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  final ThemeController _themeController = ThemeController();
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
                  ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.location_on),
                  title: Text('My Locations'),
                  trailing: Icon(TIcon.arrowForward),
                  onTap: () {
              
                  },
                ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.local_offer),
                    title: Text('My Promotions'),
                    trailing: Icon(TIcon.arrowForward),
                    onTap: () {
              
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.payment),
                    title: Text('Payment Methods'),
                    trailing: Icon(TIcon.arrowForward),
                    onTap: () {
              
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.message),
                    title: Text('Messages'),
                    trailing: Icon(TIcon.arrowForward),
                    onTap: () {
              
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.group),
                    title: Text('Invite Friends'),
                    trailing: Icon(TIcon.arrowForward),
                    onTap: () {
              
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.security),
                    title: Text('Security'),
                    trailing: Icon(TIcon.arrowForward),
                    onTap: () {
              
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.help),
                    title: Text('Help Center'),
                    trailing: Icon(TIcon.arrowForward),
                    onTap: () {
              
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Language'),
                    trailing: DropdownButton<String>(
                      value: 'English',
                      items: <String>['English', 'Spanish', 'French', 'German']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
              
                      },
                    ),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Push Notification'),
                    value: true,
                    onChanged: (bool value) {
              
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Dark Mode'),
                    trailing: Obx(() => Switch(
                      value: _themeController.isDarkMode.value,
                      onChanged: _themeController.toggleTheme,
                    )),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Sound'),
                    value: false,
                    onChanged: (bool value) {
              
                    },
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Automatically Updated'),
                    value: true,
                    onChanged: (bool value) {
              
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Term of Service'),
                    trailing: Icon(TIcon.arrowForward),
                    onTap: () {
              
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Privacy Policy'),
                    trailing: Icon(TIcon.arrowForward),
                    onTap: () {
              
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('About App'),
                    trailing: Icon(TIcon.arrowForward),
                    onTap: () {
              
                    },
                  ),
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

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
