import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/main_button.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/sliver_sized_box.dart';
import 'package:food_delivery_app/features/personal/controllers/theme_controller.dart';
import 'package:food_delivery_app/features/personal/views/about_app/personal_about_app.dart';
import 'package:food_delivery_app/features/personal/views/help_center/personal_help_center.dart';
import 'package:food_delivery_app/features/personal/views/invite/personal_invite.dart';
import 'package:food_delivery_app/features/personal/views/message/personal_message.dart';
import 'package:food_delivery_app/features/personal/views/privacy_policy/personal_privacy_policy.dart';
import 'package:food_delivery_app/features/personal/views/security/personal_security.dart';
import 'package:food_delivery_app/features/personal/views/term_of_service/personal_term_of_service.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class PersonalProfileView extends StatelessWidget {
  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Profile",
            iconList: [
              {
                "icon": Icons.more_horiz
              }
            ],
            noLeading: true,
          ),

          SliverToBoxAdapter(
            child: MainWrapper(
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thomas K. Wilson',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                        ),
                        Text(
                          '(+44) 20 1234 5629',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'thomas.abc.inc@gmail.com',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    trailing: CircleIconCard(
                        icon: Icons.edit,
                        iconColor: TColor.light,
                        backgroundColor: TColor.primary,
                      ),
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
                  )
                ],
              ),
            ),
          ),
          SliverSizedBox(height: TSize.spaceBetweenItemsVertical,),

          SliverToBoxAdapter(
            child: MainWrapper(
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.location_on),
                    title: Text('My Locations'),
                    trailing: Icon(TIcon.arrowFoward),
                    onTap: () {
                      Get.to(PersonalMessageView());
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.local_offer),
                    title: Text('My Promotions'),
                    trailing: Icon(TIcon.arrowFoward),
                    onTap: () {
                      Get.to(PersonalMessageView());
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.payment),
                    title: Text('Payment Methods'),
                    trailing: Icon(TIcon.arrowFoward),
                    onTap: () {
                      Get.to(PersonalMessageView());
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.message),
                    title: Text('Messages'),
                    trailing: Icon(TIcon.arrowFoward),
                    onTap: () {
                      Get.to(PersonalMessageView());
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.group),
                    title: Text('Invite Friends'),
                    trailing: Icon(TIcon.arrowFoward),
                    onTap: () {
                      Get.to(PersonalInviteView());
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.security),
                    title: Text('Security'),
                    trailing: Icon(TIcon.arrowFoward),
                    onTap: () {
                      Get.to(PersonalSecurityView());
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.help),
                    title: Text('Help Center'),
                    trailing: Icon(TIcon.arrowFoward),
                    onTap: () {
                      Get.to(PersonalHelpCenterView());
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
                    trailing: Icon(TIcon.arrowFoward),
                    onTap: () {
                      Get.to(PersonalTermOfServiceView());
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Privacy Policy'),
                    trailing: Icon(TIcon.arrowFoward),
                    onTap: () {
                      Get.to(PersonalPrivacyPolicyView());
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('About App'),
                    trailing: Icon(TIcon.arrowFoward),
                    onTap: () {
                      Get.to(PersonalAboutAppView());
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (int index) {
          // Handle bottom navigation tap
        },
      ),
    );
  }
}
