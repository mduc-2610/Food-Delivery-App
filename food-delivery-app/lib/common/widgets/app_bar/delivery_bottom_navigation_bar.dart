import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/views/restaurant/widgets/restaurant_basket.dart';
import 'package:food_delivery_app/features/user/order/controllers/basket/order_basket_controller.dart';
import 'package:food_delivery_app/features/user/order/views/basket/order_basket.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class DeliveryBottomNavigationBar extends StatelessWidget {
  const DeliveryBottomNavigationBar({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final controller = RestaurantDetailController.instance;
    $print(controller.totalItems.value);
    return
      Obx(() =>
      (controller.totalItems.value == 0)
          ? SizedBox.shrink()
          : InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return Obx(() {
                  if (controller.totalItems.value == 0) {
                    Get.back();
                  }
                  return RestaurantBasket(
                    height: TDeviceUtil.getScreenHeight() * 3 / 4,);
                });
              });
        },
        child: Container(
          height: TSize.bottomNavigationBarHeight,
          child: MainWrapper(
            rightMargin: 0,
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: double.infinity,
                      child: Icon(
                        Icons.add_shopping_cart,
                        color: TColor.primary,
                        size: TSize.iconLg,
                      ),
                    ),
                    if(controller.totalItems.value != 0)...[
                      Obx(() => Positioned(
                        top: 10,
                        right: -10,
                        child: CircleAvatar(
                          minRadius: 12,
                          backgroundColor: TColor.primary,
                          child: Text(
                            "${controller.totalItems.value}",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: TColor.light
                            ),
                          ),
                        ),
                      ))
                    ]
                  ],
                ),

                Spacer(),

                Obx(() => Text(
                  "£${controller.totalPrice.value.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: TColor.primary,
                  ),
                )),
                SizedBox(width: TSize.spaceBetweenItemsVertical,),

                InkWell(
                  onTap: () {
                    Get.to(() => OrderBasketView());
                  },
                  child: Container(
                    height: double.infinity,
                    width: TDeviceUtil.getScreenWidth() * 0.3,
                    color: TColor.primary,
                    child: Center(
                      child: Text(
                        "Delivery",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: TColor.light,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
      );
  }
}
