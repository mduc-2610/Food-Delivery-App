import 'dart:async';
import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/data/socket_services/socket_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class OrderTrackingController extends GetxController {
  static OrderTrackingController get instance => Get.find();
  late SocketService orderSocket;
  SocketService? delivererSocket;
  Rx<LatLng> currentPosition = LatLng(0, 0).obs;
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  Order? order;
  User? user;
  String? delivererId;
  Rx<Deliverer?> deliverer = (null as Deliverer?).obs;
  Delivery? delivery;
  late GoogleMapController _mapController;
  RxSet<Marker> markers = <Marker>{}.obs;
  RxSet<Polyline> polylines = <Polyline>{}.obs;
  String osrmBaseUrl = "https://router.project-osrm.org/route/v1/driving/";
  Timer? movementTimer;
  int polylineIndex = 0;
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  Rx<int> trackingStage = 0.obs;
  Rx<bool> isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    orderSocket = SocketService<Order>(handleIncomingMessage: handleIncomingMessage);
    orderSocket.connect();
    initializeUser();
  }

  Future<void> handleIncomingMessage(String message) async {
    $print("CUSTOM: $message");
    final decodedMessage = json.decode(message);
    if(decodedMessage["delivery"] != null) {
      $print("INITIALIZE deliverer");
      delivery = Delivery.fromJson(decodedMessage["delivery"]);
      deliverer.value = await APIService<Deliverer>().retrieve(delivery?.deliverer ?? '');
      $print(deliverer.value);
      delivererSocket = SocketService<Deliverer>(handleIncomingMessage: delivererIncomingMessage);
      delivererSocket?.connect(id: delivery?.deliverer);
      await addMarkers(delivery);
      update();
    }
  }

  Future<void> delivererIncomingMessage(String message) async {
    $print("Deliverer incoming message: $message");

    try {
      final decodedMessage = json.decode(message);
      $print("DUC: ${decodedMessage}");
      if (decodedMessage != null && decodedMessage["message"] != null) {
        final [newLatitude, newLongitude] = decodedMessage["message"]["coordinate"];

        LatLng newDelivererPosition = LatLng(newLatitude, newLongitude);
        deliverer.value?.currentCoordinate = newDelivererPosition;

        markers.removeWhere((marker) => marker.markerId == MarkerId('current'));
        markers.add(Marker(
          markerId: MarkerId('current'),
          position: newDelivererPosition,
          icon: currentIcon,
        ));

        markers.refresh();
        startMovingMarkerAlongRoute(delivery, newDelivererPosition);
        animateCamera(newDelivererPosition, newDelivererPosition);

        update();
      }
    } catch (e) {
      print("Error handling deliverer incoming message: $e");
    }
  }


  Future<void> initializeUser() async {
    user = await UserService.getUser();
    // if(delivery?.deliverer != null) {
    //   delivererSocket = SocketService<Deliverer>();
    //   delivererSocket?.connect(id: delivery?.deliverer);
    // }
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    $print(user);
    $print(isLoading.value);
    update();
  }

  void stopTracking() {
    orderSocket.disconnect();
    delivererSocket?.disconnect();
  }

  @override
  void onClose() {
    stopTracking();
    super.onClose();
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

  Future<void> onMapCreated(GoogleMapController controller) async {
    destinationIcon = await createCustomMarkerBitmap(
      user?.profile?.avatar ?? 'https://example.com/destination_icon.png',
      size: 120,
      borderColor: TColor.primary,
      borderWidth: 0,
    );
    markers.add(Marker(
      markerId: MarkerId('drop_off'),
      position: user?.selectedLocation?.currentCoordinate ?? LatLng(0, 0),
      icon: destinationIcon,
    ));
    update();
  }

  Future<void> addMarkers(Delivery? delivery, {bool isCheckRoute = true}) async {
    sourceIcon = await createCustomMarkerBitmap(
      "https://th.bing.com/th/id/OIP.J7Td_S41uQvsuGI73Pu5dwHaH_?rs=1&pid=ImgDetMain" ?? 'https://example.com/source_icon.png',
      size: 120,
      borderColor: TColor.secondary,
      borderWidth: 0,
    );

    currentIcon = await createCustomMarkerBitmap(
      deliverer.value?.avatar ?? "https://th.bing.com/th/id/OIP.J7Td_S41uQvsuGI73Pu5dwHaH_?rs=1&pid=ImgDetMain",
      size: 150,
      borderColor: Colors.blue,
      borderWidth: 0,
    );

    markers.add(Marker(
      markerId: MarkerId('current'),
      position: deliverer.value?.currentCoordinate ?? LatLng(0, 0),
      icon: currentIcon,
    ));

    markers.add(Marker(
      markerId: MarkerId('pick_up'),
      position: delivery?.pickupCoordinate ?? LatLng(0, 0),
      icon: sourceIcon,
    ));

    markers.refresh();
    update();
    await getPolyPoints(delivery);
    // if(!isCheckRoute) startMovingMarkerAlongRoute(delivery);
  }

  Future<void> getPolyPoints(Delivery? delivery) async {
    LatLng start = deliverer.value?.currentCoordinate ?? LatLng(0, 0);
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

  bool isNearLocation(LatLng currentPosition, LatLng targetPosition, {double thresholdInMeters = 500}) {
    final double distance = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      targetPosition.latitude,
      targetPosition.longitude,
    );
    $print("Distance: ${distance} ${thresholdInMeters}");
    $print("Tracking stage: ${trackingStage}");
    return distance <= thresholdInMeters;
  }

  void startMovingMarkerAlongRoute(Delivery? delivery, LatLng newPosition) {
    if (polylineCoordinates.isEmpty) return;
    $print("Tracking stage: ${trackingStage.value}");
    // movementTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
    //   if (delivery == null) {
    //     timer.cancel();
    //     return;
    //   }
      if(delivery == null) {
        return;
      }

      LatLng currentPoint = newPosition;

      if (trackingStage.value == 1 && isNearLocation(currentPoint, delivery.pickupCoordinate)) {
        trackingStage.value = 2;
      }

      if (trackingStage.value == 0 && isNearLocation(currentPoint, delivery.pickupCoordinate)) {
        trackingStage.value = 1;
      }

      if (trackingStage.value == 2 && isNearLocation(currentPoint, delivery.dropOffCoordinate)) {
        trackingStage.value = 3;
      }
      update();

      // if (polylineIndex < polylineCoordinates.length - 1) {
      //   LatLng currentLatLng = polylineCoordinates[polylineIndex];
      //   LatLng nextLatLng = polylineCoordinates[polylineIndex + 1];
      //
      //   markers.removeWhere((marker) => marker.markerId == MarkerId('current'));
      //
      //   markers.add(Marker(
      //     markerId: MarkerId('current'),
      //     position: currentLatLng,
      //     icon: currentIcon,
      //   ));
      //
      //   markers.refresh();

        Polyline completedRoute = Polyline(
          polylineId: PolylineId('completed_route'),
          points: polylineCoordinates.sublist(0, polylineIndex + 1),
          color: TColor.primary,
          width: 5,
        );

        Polyline remainingRoute = Polyline(
          polylineId: PolylineId('remaining_route'),
          points: polylineCoordinates.sublist(polylineIndex),
          color: Colors.red,
          width: 5,
        );

        polylines.clear();
        polylines.addAll([completedRoute, remainingRoute]);

        update();

      //   animateCamera(currentLatLng, nextLatLng);
      //
      //   polylineIndex++;
      // }
      // else {
      //   timer.cancel();
      // }
    // });
  }

  void animateCamera(LatLng from, LatLng to) {
    final CameraUpdate cameraUpdate = CameraUpdate.newLatLng(to);
    _mapController.animateCamera(cameraUpdate);
  }

  void handleCancel() {
    $print("Incoming message: ${orderSocket.incomingMessage}");
  }
}
