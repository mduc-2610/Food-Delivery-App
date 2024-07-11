import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/personal/controllers/profile/theme_controller.dart';
import 'package:food_delivery_app/features/personal/views/about_app/personal_about_app.dart';
import 'package:food_delivery_app/features/personal/views/help_center/personal_help_center.dart';
import 'package:food_delivery_app/features/personal/views/invite/personal_invite.dart';
import 'package:food_delivery_app/features/personal/views/message/personal_message.dart';
import 'package:food_delivery_app/features/personal/views/privacy_policy/personal_privacy_policy.dart';
import 'package:food_delivery_app/features/personal/views/security/personal_security.dart';
import 'package:food_delivery_app/features/personal/views/term_of_service/personal_term_of_service.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class PersonalSetting extends StatelessWidget {
  final List<String> exclude;
  final List<String> include;

  const PersonalSetting({
    super.key,
    required ThemeController themeController,
    this.exclude = const [],
    this.include = const [],
  }) : _themeController = themeController;

  final ThemeController _themeController;

  bool shouldInclude(String item) {
    if(include.contains('__all__')) {
      return true;
    }
    else if(exclude.contains('__all__')) {
      return false;
    }
    else {
      if (include.isNotEmpty) {
        return include.contains(item);
      }
      return !exclude.contains(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (shouldInclude('location')) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.location_on),
            title: Text('My Locations'),
            trailing: Icon(TIcon.arrowForward),
            onTap: () {
              Get.to(PersonalMessageView());
            },
          ),
        ],
        if (shouldInclude('promotion')) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.local_offer),
            title: Text('My Promotions'),
            trailing: Icon(TIcon.arrowForward),
            onTap: () {
              Get.to(PersonalMessageView());
            },
          ),
        ],
        if (shouldInclude('payment')) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.payment),
            title: Text('Payment Methods'),
            trailing: Icon(TIcon.arrowForward),
            onTap: () {
              Get.to(PersonalMessageView());
            },
          ),
        ],
        if (shouldInclude('message')) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.message),
            title: Text('Messages'),
            trailing: Icon(TIcon.arrowForward),
            onTap: () {
              Get.to(PersonalMessageView());
            },
          ),
        ],
        if (shouldInclude('invite')) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.group),
            title: Text('Invite Friends'),
            trailing: Icon(TIcon.arrowForward),
            onTap: () {
              Get.to(PersonalInviteView());
            },
          ),
        ],
        if (shouldInclude('security')) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.security),
            title: Text('Security'),
            trailing: Icon(TIcon.arrowForward),
            onTap: () {
              Get.to(PersonalSecurityView());
            },
          ),
        ],
        if (shouldInclude('help')) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.help),
            title: Text('Help Center'),
            trailing: Icon(TIcon.arrowForward),
            onTap: () {
              Get.to(PersonalHelpCenterView());
            },
          ),
        ],
        if (shouldInclude('language')) ...[
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
              onChanged: (String? newValue) {},
            ),
          ),
        ],
        if (shouldInclude('notification')) ...[
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Push Notification'),
            value: true,
            onChanged: (bool value) {},
          ),
        ],
        if (shouldInclude('dark_mode')) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Dark Mode'),
            trailing: Obx(() => Switch(
              value: _themeController.isDarkMode.value,
              onChanged: _themeController.toggleTheme,
            )),
          ),
        ],
        if (shouldInclude('sound')) ...[
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Sound'),
            value: false,
            onChanged: (bool value) {},
          ),
        ],
        if (shouldInclude('auto_update')) ...[
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Automatically Updated'),
            value: true,
            onChanged: (bool value) {},
          ),
        ],
        if (shouldInclude('term_of_service')) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Term of Service'),
            trailing: Icon(TIcon.arrowForward),
            onTap: () {
              Get.to(PersonalTermOfServiceView());
            },
          ),
        ],
        if (shouldInclude('privacy_policy')) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Privacy Policy'),
            trailing: Icon(TIcon.arrowForward),
            onTap: () {
              Get.to(PersonalPrivacyPolicyView());
            },
          ),
        ],
        if (shouldInclude('about')) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('About App'),
            trailing: Icon(TIcon.arrowForward),
            onTap: () {
              Get.to(PersonalAboutAppView());
            },
          ),
        ],
      ],
    );
  }
}
