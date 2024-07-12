import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class MessagesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      child: ListView(
        children: [
          CSearchBar(),
          SizedBox(height: TSize.spaceBetweenItemsVertical,),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text('Royal Porvaj'),
            subtitle: Text('Sounds awesome!'),
            trailing: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 10,
              child: Text('1', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),ListTile(
            contentPadding: EdgeInsets.zero,
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
      ),
    );
  }
}
