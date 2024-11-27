import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/misc/list_check.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/personal/views/profile/profile.dart';
import 'package:food_delivery_app/features/user/food/views/restaurant/restaurant_detail.dart';
import 'package:food_delivery_app/features/user/order/controllers/common/order_info_controller.dart';
import 'package:food_delivery_app/features/user/order/controllers/history/order_history_detail_controller.dart';
import 'package:food_delivery_app/features/user/order/views/basket/widgets/order_card.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/order_info.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/order_bottom_navigation_bar.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/features/user/order/views/history/widgets/order_history_detail_sliver_app_bar.dart';
import 'package:food_delivery_app/features/user/order/views/rating/order_rating.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderHistoryDetailView extends StatelessWidget {
  final ViewType viewType;

  const OrderHistoryDetailView({
    this.viewType = ViewType.user
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderHistoryDetailController>(
      init: OrderHistoryDetailController(),
      builder: (controller) {
        return
          Scaffold(
              body:
              CustomScrollView(
                slivers: [
                  //
                  // CSliverAppBar(
                  //   title: "My History",
                  //   result: {
                  //     'order': controller.order
                  //   },
                  // ),
                  OrderHistoryDetailSliverAppBar(),
                  SliverList(
                    delegate: SliverChildListDelegate([

                      Obx(() =>
                      controller.isLoading.value
                          ? OrderBasketSkeleton()
                          : Column(
                        children: [
                          if(!controller.isLoading.value)...[
                            SingleChildScrollView(
                                child: Center(
                                  child: ListCheck(
                                    checkEmpty: controller.order?.cart.cartDishes.length == 0,
                                    child: Column(
                                      children: [
                                        MainWrapper(
                                          topMargin: TSize.spaceBetweenItemsVertical,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${controller.order?.restaurant?.basicInfo?.name}",
                                                  style: Get.textTheme.headlineMedium?.copyWith(
                                                    // color: TColor.primary,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                          
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(() => RestaurantDetailView(), arguments: {
                                                    'id': controller.order?.restaurant?.id
                                                  });
                                                },
                                                child: Text(
                                                  "See detail",
                                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                    decoration: TextDecoration.underline,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: TSize.spaceBetweenItemsVertical,),
                                        if (controller.order?.status == "COMPLETED")
                                          MainWrapper(
                                            child: Stack(
                                              children: [
                                                SmallButton(
                                                    onPressed: () async {
                                                      final result = await Get.to(() => OrderRatingView(), arguments: {
                                                        "order": controller.order
                                                      }) as Map<String, dynamic>?;
                                                      $print(result?["isUpdated"]);
                                                      if(result != null && result["isUpdated"] == true) {
                                                        await controller.initialize();
                                                      }
                                                    },
                                                    text: "Rating your order"
                                                ),
                                                if(controller.order?.isReviewed == false)...[
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: SvgPicture.asset(
                                                      TIcon.notifyDot,
                                                    ),
                                                  )
                                                ],
                                              ],
                                            ),
                                          ),
                            
                                        MainWrapper(
                                          topMargin: TSize.spaceBetweenItemsVertical,
                                          bottomMargin: TSize.spaceBetweenItemsVertical,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Order summary',
                                                    style: Theme.of(context).textTheme.titleSmall,
                                                  ),
                                                  Text(
                                                    '${controller.order?.id?.split('-')[0].toString() ?? ''}',
                                                    style: Theme.of(context).textTheme.headlineSmall,
                                                  ),
                                                ],
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
                                  ),
                                )
                            )
                          ]

                        ],
                      ),
                      )
                    ]),
                  )
                ],
              ),
            bottomNavigationBar:
            viewType == ViewType.user
            ? Obx(() =>
            controller.isLoading.value
                ? OrderBottomNavigationBarSkeleton()
                :  OrderBottomNavigationBar(
              order: controller.order,
              viewType: OrderViewType.history,
            ))
            : null,
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


