import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/order/controllers/tracking/order_tracking_controller.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/features/user/order/views/tracking/widgets/order_tracking.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';


class OrderTrackingView extends StatefulWidget {
  @override
  _OrderTrackingViewState createState() => _OrderTrackingViewState();
}

class _OrderTrackingViewState extends State<OrderTrackingView> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  LatLng driverLocation = LatLng(37.7749, -122.4194);
  LatLng destinationLocation = LatLng(37.7816, -122.4090);
  final orderTrackingController = Get.put(OrderTrackingController());

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
      appBar: CAppBar(
        title: 'Order Tracking',
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
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircleIconCard(
                    icon: TIcon.delivery,
                    iconColor: TColor.light,
                    iconSize: TSize.iconLg,
                    backgroundColor: TColor.primary,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return OrderTracking(onCancel: () {},);
                        },
                        barrierColor: Colors.black.withOpacity(0.3),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}


