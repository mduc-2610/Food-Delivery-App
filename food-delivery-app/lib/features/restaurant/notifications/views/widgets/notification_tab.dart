import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';

class NotificationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      child: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Tanvir Ahmad'),
            subtitle: Text('Missed a call'),
            trailing: Text('10:30 AM'),
          ),
        ],
      ),
    );
  }
}