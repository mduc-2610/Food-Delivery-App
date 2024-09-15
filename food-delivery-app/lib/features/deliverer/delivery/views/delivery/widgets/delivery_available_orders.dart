import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/list_check.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/deliverer/delivery/controllers/delivery/delivery_controller.dart';
import 'package:food_delivery_app/features/deliverer/home/views/home/widgets/delivery_card.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';


class DeliveryAvailableOrders extends StatelessWidget {
  final DeliveryController deliveryController;
  final BuildContext context;

  const DeliveryAvailableOrders({
    super.key,
    required this.deliveryController,
    required this.context,
  });


  @override
  Widget build(BuildContext context) {
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
                              deliveryRequest: delivery,
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

class DeliveryAvailableOrdersSkeleton extends StatelessWidget {
  const DeliveryAvailableOrdersSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainWrapper(
            child: BoxSkeleton(
              height: 30,
              width: 250,
              borderRadius: TSize.borderRadiusSm,
            ),
          ),
          SizedBox(height: TSize.spaceBetweenItemsVertical),
          MainWrapper(
            rightMargin: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 3; i++) ...[
                    SizedBox(
                      width: TDeviceUtil.getScreenWidth() * 0.85,
                      child: DeliveryCardSkeleton(),
                    ),
                    SizedBox(width: TSize.spaceBetweenItemsLg),
                  ]
                ],
              ),
            ),
          ),
          SizedBox(height: TSize.spaceBetweenSections),
        ],
      ),
    );
  }
}