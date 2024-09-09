import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TMapFunction {
  TMapFunction._();

  static Future<BitmapDescriptor> createCustomMarkerBitmap(String imageUrl, {
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

  static Future<List<LatLng>> getPolyCoordinates(List<LatLng> coordinates) async {
    String osrmBaseUrl = "https://router.project-osrm.org/route/v1/driving/";
    String routeUrl = "$osrmBaseUrl";

    for (var coord in coordinates) {
      routeUrl += "${coord.longitude},${coord.latitude};";
    }

    routeUrl = routeUrl.substring(0, routeUrl.length - 1) + "?geometries=geojson";

    try {
      final response = await http.get(Uri.parse(routeUrl));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);

        if (decodedData['routes'].isNotEmpty) {
          final route = decodedData['routes'][0];
          final routeCoordinates = route['geometry']['coordinates'];
          List<LatLng> polyCoordinates = [];

          for (var coord in routeCoordinates) {
            double lon = coord[0];
            double lat = coord[1];
            polyCoordinates.add(LatLng(lat, lon));
          }

          return polyCoordinates;
        }
      } else {
        print('Error fetching route from OSRM: ${response.body}');
      }
    } catch (e) {
      print('Exception caught while fetching route: $e');
    }

    return [];
  }

  static Future<Marker> createMarker(String markerId, {
    String? avatar,
    double? size,
    Color? borderColor,
    double? borderWidth,
    LatLng? coordinate,
    BitmapDescriptor? icon,
    Set<Marker>? markers,
  }) async {
    final bitMapDescriptorImage = await TMapFunction.createCustomMarkerBitmap(
      avatar ?? 'https://www.bing.com/images/search?view=detailV2&ccid=jPwfygtS&id=0292812677F30AD5785F40BA8BDBCF0C5CC3BF44&thid=OIP.jPwfygtS-rvpGhJ6A-Y1BwHaEK&mediaurl=https%3A%2F%2Fi.ytimg.com%2Fvi%2Fym6dRz1jHFQ%2Fmaxresdefault.jpg&cdnurl=https%3A%2F%2Fth.bing.com%2Fth%2Fid%2FR.8cfc1fca0b52fabbe91a127a03e63507%3Frik%3DRL%252fDXAzP24u6QA%26pid%3DImgRaw%26r%3D0&exph=720&expw=1280&q=animation+2d+image&simid=608027358347868647&FORM=IRPRST&ck=925AE2376F8EC802D646031ED0D8E00D&selectedIndex=8&itb=0&cw=1310&ch=629&ajaxhist=0&ajaxserp=0',
      size: size ?? 120,
      borderColor: borderColor ?? TColor.primary,
      borderWidth: borderWidth ?? 0,
    );
    final marker = Marker(
      markerId: MarkerId(markerId),
      position: coordinate ?? LatLng(0, 0),
      icon: icon ?? bitMapDescriptorImage,
    );
    markers?.add(marker);
    return marker;
  }

  static bool isNearLocation(LatLng currentPosition, LatLng targetPosition, {double thresholdInMeters = 500}) {
    final double distance = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      targetPosition.latitude,
      targetPosition.longitude,
    );
    return distance <= thresholdInMeters;
  }

  static void updateMarkerCoordinate({
      LatLng? coordinate,
      required Set<Marker> markers,
  }) {
    BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;
    markers.removeWhere((marker) {
      if(marker.markerId == MarkerId('current')) {
        currentIcon = marker.icon;
        return true;
      }
      return false;
    });
    markers.add(Marker(
      markerId: MarkerId('current'),
      position: coordinate ?? LatLng(0, 0),
      icon: currentIcon,
    ));
  }

  static Iterable<Polyline> updatePolylineColor({
    Set<Polyline>? polylines,
    required List<LatLng> coordinates,
    required int index,
    Color? completeColor,
    Color? remainColor,
  }) {
    Polyline completedRoute = Polyline(
      polylineId: PolylineId('completed_route'),
      points: coordinates.sublist(0, index + 1),
      color: completeColor ?? TColor.primary,
      width: 5,
    );

    Polyline remainingRoute = Polyline(
      polylineId: PolylineId('remaining_route'),
      points: coordinates.sublist(index),
      color: remainColor ?? Colors.red,
      width: 5,
    );

    polylines?.clear();
    polylines?.addAll([completedRoute, remainingRoute]);
    return [completedRoute, remainingRoute] as Iterable<Polyline>;
  }

  static void animateCamera(GoogleMapController controller, LatLng from, LatLng to) {
    final CameraUpdate cameraUpdate = CameraUpdate.newLatLng(to);
    controller.animateCamera(cameraUpdate);
  }
}