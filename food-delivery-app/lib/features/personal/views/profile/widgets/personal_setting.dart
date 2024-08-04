import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/notification/views/notification.dart';
import 'package:food_delivery_app/features/personal/controllers/profile/theme_controller.dart';
import 'package:food_delivery_app/features/personal/views/about_app/personal_about_app.dart';
import 'package:food_delivery_app/features/personal/views/help_center/personal_help_center.dart';
import 'package:food_delivery_app/features/personal/views/invite/personal_invite.dart';
import 'package:food_delivery_app/features/personal/views/privacy_policy/personal_privacy_policy.dart';
import 'package:food_delivery_app/features/personal/views/security/personal_security.dart';
import 'package:food_delivery_app/features/personal/views/term_of_service/personal_term_of_service.dart';
import 'package:food_delivery_app/features/user/order/views/location/order_location.dart';
import 'package:food_delivery_app/features/user/payment/views/payment/payment_list.dart';
import 'package:food_delivery_app/features/user/personal/controller/personal_profile_controller.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class PersonalSetting extends StatefulWidget {
  final List<String> exclude;
  final List<String> include;

  const PersonalSetting({
    super.key,
    this.exclude = const [],
    this.include = const [],
  });

  @override
  State<PersonalSetting> createState() => _PersonalSettingState();
}

class _PersonalSettingState extends State<PersonalSetting> {
  final _themeController = Get.put(ThemeController());
  final _personalProfileController = PersonalProfileController.instance;


  bool shouldInclude(String item) {
    if(widget.include.contains('__all__')) {
      return true;
    }
    else if(widget.exclude.contains('__all__')) {
      return false;
    }
    else {
      if (widget.include.isNotEmpty) {
        return widget.include.contains(item);
      }
      return !widget.exclude.contains(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    final setting = _personalProfileController.user?.setting;
    return Column(
      children: [
        if (shouldInclude('location')) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.location_on),
            title: Text('My Locations'),
            trailing: Icon(TIcon.arrowForward),
            onTap: () {
              Get.to(OrderLocationSelectView());
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
              Get.to(PaymentListView());
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
            trailing: Obx(() => DropdownButton<String>(
              value: _personalProfileController.language.value,
              items: ['English', 'Vietnamese']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value.toUpperCase(),
                  child: Text(value),
                );
              }).toList(),
              onChanged: _personalProfileController.changeLanguage,
            ),)
          ),
        ],
        if (shouldInclude('notification')) ...[
          Obx(() => SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Notification'),
            value: _personalProfileController.notification.value,
            onChanged: _personalProfileController.toggleNotification,
          ),)
        ],
        if (shouldInclude('dark_mode')) ...[
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Dark Mode'),
            trailing: Obx(() => Switch(
              value: _personalProfileController.darkMode.value,
              onChanged: _personalProfileController.toggleTheme,
            )),
          ),
        ],
        if (shouldInclude('sound')) ...[
          Obx(() => SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Sound'),
            value: _personalProfileController.sound.value,
            onChanged: _personalProfileController.toggleSound,
          ),)
        ],
        if (shouldInclude('auto_update')) ...[
          Obx(() => SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Automatically Updated'),
            value: _personalProfileController.automaticallyUpdated.value,
            onChanged: _personalProfileController.toggleAutomaticallyUpdated,
          ),)
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
