import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/order/models/location.dart';
import 'package:food_delivery_app/features/order/views/location/widgets/order_location_list.dart';
import 'package:provider/provider.dart';

class LocationSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.grey[850],
          child: Column(
            children: [
              Expanded(
                child: Consumer<LocationModel>(
                  builder: (context, locationModel, child) {
                    return LocationList(locations: locationModel.locations);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('Apply'),
                  onPressed: () {
                    // Handle apply action
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}