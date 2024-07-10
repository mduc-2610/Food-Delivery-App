import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/features/restaurant/notifications/views/widgets/message_tab.dart';
import 'package:food_delivery_app/features/restaurant/notifications/views/widgets/notification_tab.dart';


class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CAppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Notification'),
              Tab(text: 'Messages'),
            ],
          ),
          title: 'Notification',
          noLeading: true,
        ),
        body: TabBarView(
          children: [
            NotificationTab(),
            MessagesTab(),
          ],
        ),
      ),
    );
  }
}
