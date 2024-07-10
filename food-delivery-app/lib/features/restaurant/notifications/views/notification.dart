import 'package:flutter/material.dart';


class RestaurantNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Notification'),
                Tab(text: 'Messages'),
              ],
            ),
            title: Text('My App'),
          ),
          body: TabBarView(
            children: [
              NotificationTab(),
              MessagesTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: CircleAvatar(),
          title: Text('Tanvir Ahmad'),
          subtitle: Text('Missed a call'),
          trailing: Text('10:30 AM'),
        ),
        // Add more ListTiles for other notifications
      ],
    );
  }
}

class MessagesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: CircleAvatar(),
          title: Text('Royal Porvaj'),
          subtitle: Text('Sounds awesome!'),
          trailing: CircleAvatar(
            backgroundColor: Colors.orange,
            radius: 10,
            child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ),
        // Add more ListTiles for other messages
      ],
    );
  }
}
