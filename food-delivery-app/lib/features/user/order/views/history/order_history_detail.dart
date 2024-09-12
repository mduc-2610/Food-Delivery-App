import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/list_check.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/user/order/controllers/common/order_info.dart';
import 'package:food_delivery_app/features/user/order/controllers/history/order_history_detail_controller.dart';
import 'package:food_delivery_app/features/user/order/views/basket/widgets/order_card.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/order_info.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/order_bottom_navigation_bar.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class OrderHistoryDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderHistoryDetailController>(
      init: OrderHistoryDetailController(),
      builder: (controller) {
        return
          Scaffold(
              appBar: CAppBar(
                title: "My Basket",
                result: {
                  'order': controller.order
                },
              ),
              body:
              Obx(() =>
              controller.isLoading.value
                  ? OrderBasketSkeleton()
                  : Column(
                children: [
                  if(!controller.isLoading.value)...[
                    Expanded(
                      child: SingleChildScrollView(
                          child: ListCheck(
                            checkEmpty: controller.order?.cart.cartDishes.length == 0,
                            child: Column(
                              children: [
                                MainWrapper(
                                  topMargin: TSize.spaceBetweenItemsVertical,
                                  bottomMargin: TSize.spaceBetweenItemsVertical,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order summary',
                                        style: Theme.of(context).textTheme.headlineSmall,
                                      ),

                                      StatusChip(status: controller.order?.status ?? "")
                                    ],
                                  ),
                                ),
                                Column(
                                    children: [
                                      for (var cartDish in controller.order?.cart.cartDishes)
                                        OrderCard(
                                          cartDish: cartDish,
                                          isCompletedOrder: false,
                                          canEdit: false,
                                        ),
                                    ],
                                  ),


                                SizedBox(height: TSize.spaceBetweenSections,),

                                OrderInfo(
                                  order: controller.order,
                                  viewType: OrderViewType.history,
                                ),
                                SizedBox(height: TSize.spaceBetweenSections,),
                              ],
                            ),
                          )
                      ),
                    )
                  ]

                ],
              ),
              ),
            bottomNavigationBar: Obx(() =>
            controller.isLoading.value
                ? OrderBottomNavigationBarSkeleton()
                :  OrderBottomNavigationBar(
              order: controller.order,
              viewType: OrderViewType.history,
            )
            ),
          );
      },
    );
  }
}

class OrderBasketSkeleton extends StatelessWidget {
  const OrderBasketSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MainWrapper(
        child: Column(
          children: [
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoxSkeleton(
                  height: 20,
                  width: 150,
                  borderRadius: TSize.sm,
                ),
                BoxSkeleton(
                  height: 20,
                  width: 100,
                  borderRadius: TSize.sm,
                ),
              ],
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            Column(
              children: List.generate(
                3,
                    (index) => OrderCardSkeleton(),
              ),
            ),
            DeliveryDetailSkeleton(),
            SizedBox(height: TSize.spaceBetweenSections),
          ],
        ),
      ),
    );
  }
}


