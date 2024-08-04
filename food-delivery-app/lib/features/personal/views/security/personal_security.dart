import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/personal/controllers/security/personal_security_controller.dart';
import 'package:get/get.dart';

class PersonalSecurityView extends StatefulWidget {
  PersonalSecurityView({Key? key}) : super(key: key);

  @override
  State<PersonalSecurityView> createState() => _PersonalSecurityViewState();
}

class _PersonalSecurityViewState extends State<PersonalSecurityView> {
  final _controller = Get.put(PersonalSecurityController());

  @override
  Widget build(BuildContext context) {
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
                    Obx(() => SwitchListTile(
                      title: Text('Face ID'),
                      value: _controller.faceId.value,
                      onChanged: _controller.toggleFaceId,
                      contentPadding: EdgeInsets.zero,
                    )),
                    Obx(() => SwitchListTile(
                      title: Text('Touch ID'),
                      value: _controller.touchId.value,
                      onChanged: _controller.toggleTouchId,
                      contentPadding: EdgeInsets.zero,
                    )),
                    Obx(() => SwitchListTile(
                      title: Text('Pin Security'),
                      value: _controller.pinSecurity.value,
                      onChanged: _controller.togglePinSecurity,
                      contentPadding: EdgeInsets.zero,
                    )),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
