import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_google_maps_webservices/distance.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:food_delivery_app/common/widgets/dialogs/show_confirm_dialog.dart';
import 'package:food_delivery_app/data/socket_services/socket_service.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/deliverer/home/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class DeliveryController extends GetxController {
  static DeliveryController get instance => Get.find();
  final delivererHomeController = DelivererHomeController.instance;
  Deliverer? deliverer;
  late GoogleMapController _mapController;
  RxSet<Marker> markers = <Marker>{}.obs;
  RxSet<Polyline> polylines = <Polyline>{}.obs;
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  SocketService? delivererSocket;
  String osrmBaseUrl = "https://router.project-osrm.org/route/v1/driving/";
  late Rx<Location> currentLocation;
  Timer? movementTimer;
  int polylineIndex = 0;
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  Map<String, bool> mapActive = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    delivererSocket = delivererHomeController.delivererSocket;
    deliverer = delivererHomeController.deliverer;
  }

  Future<BitmapDescriptor> createCustomMarkerBitmap(String imageUrl, {
    double size = 150,
    Color borderColor = Colors.white,
    double borderWidth = 10,
    Color backgroundColor = Colors.transparent,
  }) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = backgroundColor;
    final double radius = size / 2;

    canvas.drawCircle(Offset(radius, radius), radius, paint);

    if (borderWidth > 0) {
      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth;
      canvas.drawCircle(Offset(radius, radius), radius - (borderWidth / 2), borderPaint);
    }

    final clipPath = Path()
      ..addOval(Rect.fromCircle(center: Offset(radius, radius), radius: radius - borderWidth));
    canvas.clipPath(clipPath);

    final Completer<ui.Image> completer = Completer<ui.Image>();
    final ImageStream imageStream = NetworkImage(imageUrl).resolve(ImageConfiguration());
    late final ImageStreamListener listener;
    listener = ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
      imageStream.removeListener(listener);
      completer.complete(imageInfo.image);
    }, onError: (dynamic exception, StackTrace? stackTrace) {
      imageStream.removeListener(listener);
      completer.completeError(exception, stackTrace);
    });
    imageStream.addListener(listener);

    final ui.Image image = await completer.future;
    paintImage(
      canvas: canvas,
      rect: Rect.fromCircle(center: Offset(radius, radius), radius: radius - borderWidth),
      image: image,
      fit: BoxFit.cover,
    );

    final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(
      size.toInt(),
      size.toInt(),
    );

    final  byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  void onMapCreated(GoogleMapController controller) async {
    _mapController = controller;

    currentIcon = await createCustomMarkerBitmap(
      deliverer?.avatar ?? 'https://example.com/de.png',
      size: 150,
      borderColor: Colors.blue,
      borderWidth: 0,
    );

    markers.add(Marker(
      markerId: MarkerId('current'),
      position: deliverer?.currentCoordinate ?? LatLng(0, 0),
      icon: currentIcon,
    ));
    update();
  }

  Future<void> addMarkers(Delivery? delivery, {bool isCheckRoute = true}) async {
    sourceIcon = await createCustomMarkerBitmap(
      "https://th.bing.com/th/id/OIP.J7Td_S41uQvsuGI73Pu5dwHaH_?rs=1&pid=ImgDetMain" ?? 'https://example.com/source_icon.png',
      size: 120,
      borderColor: Colors.green,
      borderWidth: 0,
    );

    destinationIcon = await createCustomMarkerBitmap(
      delivery?.user?.avatar ?? 'https://example.com/destination_icon.png',
      size: 120,
      borderColor: Colors.red,
      borderWidth: 0,
    );

    markers.add(Marker(
      markerId: MarkerId('pick_up'),
      position: delivery?.pickupCoordinate ?? LatLng(0, 0),
      icon: sourceIcon,
    ));
    markers.add(Marker(
      markerId: MarkerId('drop_off'),
      position: delivery?.dropOffCoordinate ?? LatLng(0, 0),
      icon: destinationIcon,
    ));
    markers.refresh();
    update();
    await getPolyPoints(delivery);
    if(!isCheckRoute) startMovingMarkerAlongRoute(delivery);
  }

  Future<void> getPolyPoints(Delivery? delivery) async {
    LatLng start = deliverer?.currentCoordinate ?? LatLng(0, 0);
    LatLng pickup = delivery?.pickupCoordinate ?? LatLng(0, 0);
    LatLng dropoff = delivery?.dropOffCoordinate ?? LatLng(0, 0);

    String routeUrl =
        "$osrmBaseUrl${start.longitude},${start.latitude};${pickup.longitude},${pickup.latitude};${dropoff.longitude},${dropoff.latitude}?geometries=geojson";

    try {
      final response = await http.get(Uri.parse(routeUrl));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);

        if (decodedData['routes'].isNotEmpty) {
          final route = decodedData['routes'][0];
          final coordinates = route['geometry']['coordinates'];
          print(coordinates?.length);
          polylineCoordinates.clear();

          for (var coord in coordinates) {
            double lon = coord[0];
            double lat = coord[1];
            polylineCoordinates.add(LatLng(lat, lon));
          }

          polylines.add(Polyline(
            polylineId: PolylineId('route'),
            points: polylineCoordinates,
            color: TColor.primary,
            width: 5,
          ));

          update();
        }
      } else {
        print('Error fetching route from OSRM: ${response.body}');
      }
    } catch (e) {
      print('Exception caught while fetching route: $e');
    }
  }

  bool isNearLocation(LatLng currentPosition, LatLng targetPosition, {double thresholdInMeters = 50, bool toward = true}) {
    final double distance = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      targetPosition.latitude,
      targetPosition.longitude,
    );

    if(toward)
      return distance <= thresholdInMeters;
    return distance >= thresholdInMeters;
  }

  void startMovingMarkerAlongRoute(Delivery? delivery) {
    if (polylineCoordinates.isEmpty) return;

    movementTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (delivery == null) {
        timer.cancel();
        return;
      }

      LatLng currentPoint = polylineCoordinates[polylineIndex];

      // Check if the marker is near the pickup location
      if (delivery.pickupCoordinate != null &&
          !mapActive.containsKey('store') &&
          isNearLocation(currentPoint, delivery.pickupCoordinate!)) {
        mapActive['store'] = true;
      }

      // Check if the marker is moving away from the pickup location (within 200m but not toward it)
      if (delivery.pickupCoordinate != null &&
          !mapActive.containsKey('delivery') &&
          isNearLocation(currentPoint, delivery.pickupCoordinate!, thresholdInMeters: 200, toward: false)) {
        mapActive['delivery'] = true;
      }

      // Check if the marker is near the drop-off location
      if (delivery.dropOffCoordinate != null &&
          !mapActive.containsKey('done') &&
          isNearLocation(currentPoint, delivery.dropOffCoordinate!)) {
        mapActive['done'] = true;
        mapActive['delivery'] = true;  // Ensure `delivery` is also set if reaching the drop-off point
      }

      $print(mapActive);
      update();

      // Update marker movement
      if (polylineIndex < polylineCoordinates.length - 1) {
        LatLng currentLatLng = polylineCoordinates[polylineIndex];
        LatLng nextLatLng = polylineCoordinates[polylineIndex + 1];

        // Remove and add the current marker
        markers.removeWhere((marker) => marker.markerId == MarkerId('current'));
        markers.add(Marker(
          markerId: MarkerId('current'),
          position: currentLatLng,
          icon: currentIcon,
        ));
        markers.refresh();
        update();

        // Animate the camera to follow the marker
        animateCamera(currentLatLng, nextLatLng);

        // Move to the next point in the polyline
        polylineIndex++;
      } else {
        // Stop the timer once the marker has completed the route
        timer.cancel();
      }
    });
  }


  void animateCamera(LatLng from, LatLng to) {
    final CameraUpdate cameraUpdate = CameraUpdate.newLatLng(to);
    _mapController.animateCamera(cameraUpdate);
  }

  void handleDecline(Delivery? delivery) {
    showConfirmDialog(
        Get.context!,
        title: "Are you sure ?",
        description: "This will affect your rating",
        onAccept: () async {
          var element = delivererHomeController.deliveryRequests.firstWhere((instance) => instance.delivery == delivery);
          delivererHomeController.deliveryRequests.remove(element);
          update();
        }
    );
    delivererHomeController.isOccupied.value = true;
  }

  void handleAccept(Delivery? delivery) {
    showConfirmDialog(
        Get.context!,
        title: "Are you sure ?",
        description: "Please check the route carefully",
        onAccept: () async {
          await addMarkers(delivery, isCheckRoute: false);
          Get.back();
        }
    );
    delivererHomeController.isOccupied.value = true;
  }

  void handleCheckRoute(Delivery? delivery) async {
    await addMarkers(delivery);
    Get.back();
  }

  @override
  void onClose() {
    movementTimer?.cancel();
    super.onClose();
  }
}