import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';

class PersonalSecurityView extends StatelessWidget {
  const PersonalSecurityView({super.key});

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
                    SwitchListTile(
                      title: Text('Push Notification'),
                      value: true,
                      onChanged: (bool value) {
                        // Push Notification functionality
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    SwitchListTile(
                      title: Text('Push Notification'),
                      value: true,
                      onChanged: (bool value) {
                        // Push Notification functionality
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    
                    SwitchListTile(
                      title: Text('Push Notification'),
                      value: true,
                      onChanged: (bool value) {
                        // Push Notification functionality
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
