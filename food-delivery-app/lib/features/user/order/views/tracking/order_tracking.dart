import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() => runApp(MaterialApp(home: OrderTrackingScreen()));

class OrderTrackingScreen extends StatefulWidget {
  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  LatLng driverLocation = LatLng(37.7749, -122.4194);
  LatLng destinationLocation = LatLng(37.7816, -122.4090);

  @override
  void initState() {
    super.initState();
    _addMarkers();
    _getPolyline();
  }

  void _addMarkers() {
    markers.add(Marker(
      markerId: MarkerId('driver'),
      position: driverLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    ));
    markers.add(Marker(
      markerId: MarkerId('destination'),
      position: destinationLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ));
  }

  void _getPolyline() {
    final random = Random();
    List<LatLng> randomPoints = List.generate(5, (_) {
      return LatLng(
        driverLocation.latitude + (random.nextDouble() - 0.5) * 0.01,
        driverLocation.longitude + (random.nextDouble() - 0.5) * 0.01,
      );
    });

    randomPoints.insert(0, driverLocation);
    randomPoints.add(destinationLocation);

    setState(() {
      polylines.add(Polyline(
        polylineId: PolylineId('route'),
        color: Colors.red,
        points: randomPoints,
        width: 3,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Tracking'),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: driverLocation,
              zoom: 14,
            ),
            onMapCreated: (controller) {
              mapController = controller;
            },
            markers: markers,
            polylines: polylines,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: OrderDetailsSection(),
          ),
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: DriverInfoCard(),
          ),
        ],
      ),
    );
  }
}

class DriverInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/driver_image.png'),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'David Wayne',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    Text('4.9'),
                    Text(' · ID 0997125', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.chat, color: Colors.orange),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.phone, color: Colors.orange),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class OrderDetailsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Estimated Delivery Time',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '10:25',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('My Order'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Cancel Order', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}