import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/deliverer/delivery/views/delivery/widgets/nearest_order_card.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryScreen extends StatefulWidget {
  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  late GoogleMapController _mapController;
  bool _isActiveDelivery = false;
  String _currentStage = 'Not Started';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: _isActiveDelivery ? 'Active Delivery' : 'Available Orders',
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: _buildMap(),
          ),
          Expanded(
            flex: 2,
            child: _isActiveDelivery ? _buildActiveDeliveryInfo() : _buildAvailableOrders(),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(37.7749, -122.4194),
        zoom: 12,
      ),
    );
  }

  Widget _buildAvailableOrders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Nearest Available Orders',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return SizedBox(
                width: TDeviceUtil.getScreenWidth(),
                child: NearestOrderCard(
                  orderNumber: '100$index',
                  restaurantName: 'Restaurant Name',
                  distance: (index + 1).toDouble(),
                  estimatedPay: 10.0 + index,
                  onPressed: () {
                    _acceptOrder(index);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _acceptOrder(int index) {

    setState(() {
      _isActiveDelivery = true;
    });
  }

  Widget _buildActiveDeliveryInfo() {
    return MainWrapper(

      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Order #1234 - 2 items'),
            Text('Pickup: 123 Restaurant St'),
            Text('Dropoff: 456 Customer Ave'),
            SizedBox(height: 16),
            Text('Customer Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 8),
                Text('John Doe'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 8),
                Text('(123) 456-7890'),
              ],
            ),
            SizedBox(height: 16),
            Text('Delivery Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            _buildStatusButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatusButton('Picked Up', Colors.orange),
        _buildStatusButton('En Route', Colors.blue),
        _buildStatusButton('Delivered', Colors.green),
      ],
    );
  }

  Widget _buildStatusButton(String status, Color color) {
    bool isActive = _currentStage == status;
    return ElevatedButton(
      child: Text(status),
      style: ElevatedButton.styleFrom(
        primary: isActive ? color : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          _currentStage = status;
        });
      },
    );
  }
  void showExpandableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.25,
          maxChildSize: 1,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 40,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        ListTile(title: Text('Item 1')),
                        ListTile(title: Text('Item 2')),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}