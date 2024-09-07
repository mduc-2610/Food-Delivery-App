import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/list_check.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/deliverer/delivery/controllers/delivery/delivery_controller.dart';
import 'package:food_delivery_app/features/deliverer/delivery/views/delivery/widgets/nearest_order_card.dart';
import 'package:food_delivery_app/features/deliverer/home/views/home/widgets/delivery_card.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/features/user/order/views/tracking/widgets/order_tracking.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class DeliveryScreen extends StatefulWidget {
  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final deliveryController = Get.put(DeliveryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: 'Delivery',
      ),
      body: Stack(
        children: [
          Obx(() => GoogleMap(
            onMapCreated: deliveryController.onMapCreated,
            initialCameraPosition: CameraPosition(
              target: deliveryController.deliverer?.currentCoordinate ?? LatLng(0, 0),
              zoom: 12,
            ),
            markers: deliveryController.markers.map((marker) => marker.copyWith(
                // onTapParam: () => deliveryController.onMarkerTapped(marker.markerId, context)
            )).toSet(),
            polylines: deliveryController.polylines.toSet(),
            onCameraMove: (_) {
              // if (deliveryController.isOverlayVisible.value) {
              //   // This will trigger the StreamBuilder to update the overlay position
              //   deliveryController.isOverlayVisible.refresh();
              // }
            },
            onTap: (_) {
              // Remove overlay when tapping on the map
              // deliveryController.overlayEntry.value?.remove();
            },
          )),
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
                          return
                            (!deliveryController.delivererHomeController.isOccupied.value)
                            ? _buildAvailableOrders()
                            : _buildTrackingOrder();
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

  Widget _buildTrackingOrder() {
    return OrderTracking(
      onCancel: () {
        deliveryController.delivererHomeController.isOccupied.value = false;
        Get.back();
      },
      controller: deliveryController,
      type: OrderTrackingType.deliverer,
    );
  }

  Widget _buildAvailableOrders() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainWrapper(
            child: Text(
              'Nearest Available Order (${deliveryController.delivererHomeController.deliveryRequests.length})',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SizedBox(height: TSize.spaceBetweenItemsVertical,),

          MainWrapper(
            rightMargin: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() => ListCheck(
                checkEmpty: deliveryController.delivererHomeController.deliveryRequests.length == 0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(var delivery in deliveryController.delivererHomeController.deliveryRequests)...[
                        SizedBox(
                          width: TDeviceUtil.getScreenWidth() * 0.85,
                          child: DeliveryCard(
                            delivery: delivery.delivery,
                          ),
                        ),
                        SizedBox(width: TSize.spaceBetweenItemsLg,),

                      ]
                    ]
                ),
              ))
            ),
          ),
          SizedBox(height: TSize.spaceBetweenSections,)
        ],
      ),
    );
  }
}