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
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:shimmer/shimmer.dart';


class OrderTrackingView extends StatefulWidget {
  @override
  _OrderTrackingViewState createState() => _OrderTrackingViewState();
}

class _OrderTrackingViewState extends State<OrderTrackingView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderTrackingController>(
      init: OrderTrackingController(),
      builder: (controller) {
        $print("asaas: ${controller.user?.selectedLocation}");
        return Scaffold(
          appBar: CAppBar(
            title: 'Delivery',
          ),
          body:
          Obx(() => (controller.isLoading.value)
              ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          )
              : Stack(
            children: [
              Obx(() => GoogleMap(
                onMapCreated: controller.onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: controller.user?.selectedLocation?.currentCoordinate ?? LatLng(0, 0),
                  zoom: 12,
                ),
                markers: controller.markers.toSet(),
                polylines: controller.polylines.toSet()
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
                              return OrderTracking(
                                onCancel: controller.handleCancel,
                                type: OrderTrackingType.user,
                                controller: controller,
                              );
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
          ));
      },
    );
  }

}



