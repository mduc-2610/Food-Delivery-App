import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/radio_tick.dart';
import 'package:food_delivery_app/features/order/models/location.dart';
import 'package:food_delivery_app/features/order/views/location/order_location_add.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';

class LocationList extends StatefulWidget {
  final List<MyLocation> locations;

  const LocationList({Key? key, required this.locations}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.locations.length + 1,
      itemBuilder: (context, index) {
        if (index < widget.locations.length) {
          final location = widget.locations[index];
          return ListTile(
            title: Text(location.name, style: TextStyle(color: Colors.white)),
            subtitle: Text(location.address, style: TextStyle(color: Colors.grey)),
            trailing: Transform.scale(
              scale: 1,
              child: RadioTick(
                value: index,
                groupValue: _selectedIndex,
                onChanged: (int? value) {
                  setState(() {
                    _selectedIndex = value!;
                  });
                },
              ),
            ),
          );
        } else {
          return ListTile(
            leading: Icon(Icons.add, color: Colors.deepOrange),
            title: Text('Add New Location', style: TextStyle(color: Colors.deepOrange)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddLocationScreen()),
              );
            },
          );
        }
      },
    );
  }
}

