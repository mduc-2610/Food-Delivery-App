import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/list_check.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/authentication/views/splash/splash.dart';
import 'package:food_delivery_app/features/user/order/controllers/basket/order_basket_controller.dart';
import 'package:food_delivery_app/features/user/order/controllers/common/order_info_controller.dart';
import 'package:food_delivery_app/features/user/order/controllers/history/order_history_detail_controller.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/features/user/order/views/basket/widgets/order_card.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/order_info.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/order_bottom_navigation_bar.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/features/user/order/views/promotion/order_promotion.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:loading_progress_indicator/loading_progress_indicator.dart';

class OrderBasketView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderBasketController>(
      init: OrderBasketController(),
      builder: (controller) {
        final restaurantCart = controller.order?.cart;
        // $print(controller.restaurantDetailController.user?.restaurantCart);
        return
          Scaffold(
              appBar: CAppBar(
                title: "My Basket",
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
                        child: Obx(() {
                          int length = controller.restaurantDetailController.cartDishes.length;
                          return ListCheck(
                            checkEmpty: length == 0,
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

                                      StatusChip(status: restaurantCart?.order?.status ?? "PENDING")
                                    ],
                                  ),
                                ),
                                Obx(() {
                                  return Column(
                                    children: [
                                      for (var cartDish in controller.restaurantDetailController.cartDishes)
                                        OrderCard(
                                          cartDish: cartDish,
                                          isCompletedOrder: false,
                                        ),
                                    ],
                                  );
                                }),

                                SizedBox(height: TSize.spaceBetweenSections,),

                                Obx(() => OrderInfo(
                                  order: controller.foodListController.order.value,
                                  viewType: OrderViewType.basket,
                                  onPromotionPressed: controller.onPromotionPressed,
                                )),
                                SizedBox(height: TSize.spaceBetweenSections,),
                              ],
                            ),
                          );
                        })
                      ),
                    )
                  ]

                ],
              ),
              ),
            bottomNavigationBar: Obx(() =>
                controller.isLoading.value
              ? SizedBox.shrink()
              : OrderBottomNavigationBar(
              order: controller.foodListController.order.value,
              viewType: OrderViewType.basket,
            )),
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


