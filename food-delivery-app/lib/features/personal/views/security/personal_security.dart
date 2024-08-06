import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/personal/controllers/security/personal_security_controller.dart';
import 'package:get/get.dart';

class PersonalSecurityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalSecurityController>(
      init: PersonalSecurityController(),
      builder: (controller) {
        var securitySetting = controller.securitySetting;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              CSliverAppBar(
                title: "Security",
                iconList: [
                  {
                    "icon": Icons.more_horiz
                  }
                ],
              ),
              SliverToBoxAdapter(
                child: MainWrapper(
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: Text('Face ID'),
                        value: securitySetting?.faceId ?? false,
                        onChanged: controller.toggleFaceId,
                        contentPadding: EdgeInsets.zero,
                      ),
                      SwitchListTile(
                        title: Text('Touch ID'),
                        value: securitySetting?.touchId ?? false,
                        onChanged: controller.toggleTouchId,
                        contentPadding: EdgeInsets.zero,
                      ),
                      SwitchListTile(
                        title: Text('Pin Security'),
                        value: securitySetting?.pinSecurity ?? false,
                        onChanged: controller.togglePinSecurity,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
