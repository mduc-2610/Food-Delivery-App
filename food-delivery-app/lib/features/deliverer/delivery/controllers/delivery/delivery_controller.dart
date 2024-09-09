import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/distance.dart';
import 'package:food_delivery_app/common/widgets/dialogs/show_confirm_dialog.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/socket_services/socket_service.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/deliverer/home/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:food_delivery_app/utils/helpers/map_functions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryController extends GetxController {
  static DeliveryController get instance => Get.find();

  final delivererHomeController = DelivererHomeController.instance;
  late GoogleMapController _mapController;

  SocketService? delivererSocket;

  Rx<int> trackingStage = 0.obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  RxSet<Polyline> polylines = <Polyline>{}.obs;
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  late Rx<Location> currentLocation;

  Deliverer? deliverer;
  Timer? movementTimer;
  int polylineIndex = 0;

  @override
  void onInit() {
    super.onInit();
    delivererSocket = delivererHomeController.delivererSocket;
    deliverer = delivererHomeController.deliverer;
  }

  void onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    markers.add(await TMapFunction.createMarker(
        'current',
        avatar: deliverer?.avatar,
        size: 150,
        borderColor: Colors.blue,
        borderWidth: 0,
        coordinate: deliverer?.currentCoordinate,
    ));
    update();
  }

  Future<void> addMarkers(DeliveryRequest? deliveryRequest, {bool isCheckRoute = false}) async {
    final Delivery? delivery = deliveryRequest?.delivery;
    markers.add(await TMapFunction.createMarker(
        'pick_up',
        avatar: "https://th.bing.com/th/id/OIP.J7Td_S41uQvsuGI73Pu5dwHaH_?rs=1&pid=ImgDetMain",
        size: 120,
        borderColor: TColor.secondary,
        borderWidth: 0,
        coordinate: delivery?.pickupCoordinate,
    ));

    markers.add(await TMapFunction.createMarker(
        'drop_off',
        avatar: delivery?.user?.avatar,
        size: 120,
        borderColor: TColor.primary,
        borderWidth: 0,
        coordinate: delivery?.dropOffCoordinate,
    ));

    markers.refresh();

    if(!isCheckRoute) {
      delivererSocket?.add({
        'delivery': delivery
      });
    }

    polylineCoordinates.value = await TMapFunction.getPolyCoordinates([
      deliverer?.currentCoordinate ?? LatLng(0, 0),
      delivery?.pickupCoordinate ?? LatLng(0, 0),
      delivery?.dropOffCoordinate ?? LatLng(0, 0),
    ]);
    TMapFunction.updatePolylineColor(
        polylines: polylines,
        index: 0,
        coordinates: polylineCoordinates
    );
    if(!isCheckRoute) await startMovingMarkerAlongRoute(deliveryRequest);
    update();
  }

  Future<void> startMovingMarkerAlongRoute(DeliveryRequest? deliveryRequest) async {
    final Delivery? delivery = deliveryRequest?.delivery;
    if (polylineCoordinates.isEmpty) return;

    movementTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) async {
      if (delivery == null) {
        timer.cancel();
        return;
      }
      int index = polylineIndex;
      if(polylineIndex == polylineCoordinates.length) index -= 1;
      LatLng currentPoint = polylineCoordinates[index];

      if (trackingStage.value == 1 &&
          TMapFunction.isNearLocation(currentPoint, delivery.pickupCoordinate!)) {
        trackingStage.value = 2;
      }

      if (trackingStage.value == 0 &&
          TMapFunction.isNearLocation(currentPoint, delivery.pickupCoordinate!)) {
        trackingStage.value = 1;
      }

      if (trackingStage.value == 2 &&
          TMapFunction.isNearLocation(currentPoint, delivery.dropOffCoordinate!)) {
        trackingStage.value = 3;

        final [statusCode, headers, data] = await APIService<DeliveryRequest>(fullUrl: deliveryRequest?.complete ?? "").create({}, noBearer: true);
      }

      int len = polylineCoordinates.length;

      if (polylineIndex < len) {
        LatLng currentLatLng = polylineCoordinates[polylineIndex];
        LatLng nextLatLng = polylineCoordinates[polylineIndex + (polylineIndex == len - 1 ? 0 : 1)];

        TMapFunction.updateMarkerCoordinate(markers: markers, coordinate: currentLatLng);

        TMapFunction.updatePolylineColor(
            polylines: polylines,
            index: polylineIndex,
            coordinates: polylineCoordinates
        );
        delivererSocket?.add({
          'coordinate': polylineCoordinates[polylineIndex],
          'tracking_stage': trackingStage.value,
        });

        TMapFunction.animateCamera(_mapController, currentLatLng, nextLatLng);
        polylineIndex++;
        update();
      } else {
        timer.cancel();
      }
    });
  }

  void handleDecline(DeliveryRequest? deliveryRequest) {
    final Delivery? delivery = deliveryRequest?.delivery;
    trackingStage.value = 0;
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

  void handleAccept(DeliveryRequest? deliveryRequest) {
    final Delivery? delivery = deliveryRequest?.delivery;
    trackingStage.value = 0;
    showConfirmDialog(
        Get.context!,
        title: "Are you sure ?",
        description: "Please check the route carefully",
        onAccept: () async {
          if(deliveryRequest?.accept != null) {
            final [statusCode, headers, data] = await APIService<DeliveryRequest>(fullUrl: deliveryRequest?.accept ?? "")
                .create({}, noBearer: true);
            $print(data?.status);
          }
          await addMarkers(deliveryRequest, isCheckRoute: false);
          Get.back();
        }
    );
    delivererHomeController.isOccupied.value = true;
  }

  void handleCheckRoute(DeliveryRequest? deliveryRequest) async {
    final Delivery? delivery = deliveryRequest?.delivery;
    await addMarkers(deliveryRequest, isCheckRoute: true);
    Get.back();
  }

  void handleCompleteOrder(Delivery? delivery) async {
    trackingStage.value = 0;
  }

  @override
  void onClose() {
    movementTimer?.cancel();
    super.onClose();
  }
}