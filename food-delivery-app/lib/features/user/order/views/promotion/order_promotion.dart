import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/cards/container_card.dart';
import 'package:food_delivery_app/common/widgets/misc/bottom_bar_wrapper.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/restaurant/food/views/manage/widgets/promotion_manage_card.dart';
import 'package:food_delivery_app/features/user/order/controllers/promotion/order_promotion_controller.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/features/user/order/views/promotion/order_promotion_list.dart';
import 'package:food_delivery_app/features/user/order/views/promotion/skeleton/order_promotion_skeleton.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderPromotionView extends StatelessWidget {
  final Order? order;
  final String? restaurantId;
  final Restaurant? restaurant;

  const OrderPromotionView({
    this.order,
    this.restaurantId,
    this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderPromotionController>(
      init: OrderPromotionController(
        order: order,
        restaurant: restaurant,
        restaurantId: restaurantId,
      ),
      builder: (controller) {
        return Obx(() => (controller.isLoading.value)
            ? OrderPromotionSkeleton()
            : Scaffold(
          body: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                CSliverAppBar(
                  title: "Promotions",
                ),
                SliverToBoxAdapter(
                  child: MainWrapper(
                    topMargin: TSize.spaceBetweenItemsVertical,
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Promo Code',
                            suffixIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MainWrapper(
                                  child: InkWell(
                                    onTap: () {
                                      // Apply promo code logic
                                    },
                                    child: Text(
                                      'Apply',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: TColor.primary),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: TSize.spaceBetweenSections),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    MainWrapper(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Shipping Offers',
                              style: Theme.of(context).textTheme.headlineMedium
                          ),
                          Obx(() {
                            final displayedShippingPromotions = controller.seeMoreShipping.value
                                ? controller.shippingPromotions
                                : controller.shippingPromotions.take(2).toList();
                            return
                              Column(
                              children: [
                                for(var promo in displayedShippingPromotions)
                                  PromotionManageCard(
                                    promotion: promo,
                                    viewType: ViewType.user,
                                    isChosen: promo == controller.chosenShippingPromotion.value,
                                    onChoose: () {
                                      controller.chooseShippingPromotion(promo);
                                    },
                                  ),
                                if (controller.shippingPromotions.length > 2)...[
                                  SizedBox(height: TSize.spaceBetweenItemsVertical),
                                  Center(
                                    child: InkWell(
                                      onTap: () => controller.toggleSeeMoreShipping(),
                                      child: Text(
                                        controller.seeMoreShipping.value ? 'See less' : 'See more',
                                        style: Get.theme.textTheme.titleLarge?.copyWith(
                                          color: TColor.primary,
                                          decoration: TextDecoration.underline,
                                          decorationColor: TColor.primary,
                                          decorationThickness: 2
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                            );
                          }),
                          SizedBox(height: TSize.spaceBetweenSections),
                          Text(
                              'Order Offers',
                              style: Theme.of(context).textTheme.headlineMedium
                          ),
                          Obx(() {
                            final displayedOrderPromotions = controller.seeMoreOrder.value
                                ? controller.orderPromotions
                                : controller.orderPromotions.take(2).toList();
                            return Column(
                              children: [
                                for(var promo in displayedOrderPromotions)
                                  PromotionManageCard(
                                    promotion: promo,
                                    viewType: ViewType.user,
                                    isChosen: promo == controller.chosenOrderPromotion.value,
                                    onChoose: () {
                                      controller.chooseOrderPromotion(promo);
                                    },
                                  ),
                                if (controller.shippingPromotions.length > 2)...[
                                  SizedBox(height: TSize.spaceBetweenItemsVertical),
                                  Center(
                                    child: InkWell(
                                      onTap: () => controller.toggleSeeMoreOrder(),
                                      child: Text(
                                        controller.seeMoreOrder.value ? 'See less' : 'See more',
                                        style: Get.theme.textTheme.titleLarge?.copyWith(
                                            color: TColor.primary,
                                            decoration: TextDecoration.underline,
                                            decorationColor: TColor.primary,
                                            decorationThickness: 2
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                            );
                          }),
                          SizedBox(height: TSize.spaceBetweenItemsVertical),
                          ContainerCard(
                            bgColor: TColor.iconBgCancel,
                            borderColor: Colors.transparent,
                            child: ListTile(
                              onTap: () {
                                Get.to(() => OrderPromotionListView());
                              },
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(
                                TIcon.add,
                                color: TColor.primary,
                              ),
                              title: Text(
                                "Get more promotions",
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.primary),
                              ),
                            ),
                          ),
                          SizedBox(height: TSize.spaceBetweenItemsVertical),
                        ],
                      ),
                    ),
                  ]),
                ),
              ]
          ),
          bottomNavigationBar: BottomBarWrapper(
            child: MainWrapper(
              child: Container(
                height: TDeviceUtil.getBottomNavigationBarHeight(),
                child: MainButton(
                  onPressed: controller.handleApplyPromotion,
                  text: "Apply",
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}