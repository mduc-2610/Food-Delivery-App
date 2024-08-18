import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/list_check.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/order/controllers/basket/order_basket_controller.dart';
import 'package:food_delivery_app/features/user/order/views/basket/widgets/order_card.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/delivery_detail.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderBasketView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderBasketController>(
      init: OrderBasketController(),
      builder: (controller) {
        final user = controller.user;
        final restaurantCart = user?.restaurantCart;
        final cartDishes = restaurantCart?.cartDishes ?? [];
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              CSliverAppBar(
                title: "My Basket",
              ),

              if(!controller.isLoading.value)...[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListCheck(
                        checkEmpty: cartDishes.length == 0,
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

                                  StatusChip(status: restaurantCart?.order?.status ?? "")
                                ],
                              ),
                            ),
                            for(var cartDish in cartDishes)...[
                              OrderCard(
                                cartDish: cartDish,
                                isCompletedOrder: false,
                              ),
                            ],
                            SizedBox(height: TSize.spaceBetweenSections,),

                            DeliveryDetail(
                              cart: restaurantCart,
                              fromView: "Basket",
                            ),
                            SizedBox(height: TSize.spaceBetweenSections,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]

            ],
          ),
        );
      },
    );
  }
}

