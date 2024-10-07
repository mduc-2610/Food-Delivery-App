import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/list_check.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/user/food/controllers/basket/user_basket_controller.dart';
import 'package:food_delivery_app/features/user/food/views/restaurant/restaurant_detail.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';

class UserBasketView extends StatelessWidget {
  const UserBasketView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserBasketController>(
      init: UserBasketController(),
      builder: (controller) {
        final restaurantCarts = controller.restaurantCarts;
        return Scaffold(
          appBar: CAppBar(
            title: "Cart",
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    if (controller.isLoading.value)
                      ...List.generate(
                        10,
                            (index) => RestaurantCartCardSkeleton(),
                      )
                    else
                      ListCheck(
                        checkNotFound: restaurantCarts.isEmpty,
                        child: Column(
                          children: [
                            for (var cart in restaurantCarts) ...[
                              RestaurantCartCard(restaurantCart: cart),
                              SeparateSectionBar(),
                            ],
                            SizedBox(height: TSize.spaceBetweenSections),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RestaurantCartCard extends StatelessWidget {
  final RestaurantCart? restaurantCart;

  const RestaurantCartCard({
    this.restaurantCart
  });

  @override
  Widget build(BuildContext context) {
    final restaurant = restaurantCart?.restaurant;
    return InkWell(
      onTap: () {
        Get.to(RestaurantDetailView(), arguments: {
          'id': restaurant?.id ?? ""
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: TSize.sm,
            horizontal: TDeviceUtil.getScreenWidth() * 0.05
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20000),

        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(TSize.borderRadiusMd),
              child: Image.asset(
                "${TImage.hcBurger1}",
                width: TSize.imageThumbSize,
                height: TSize.imageThumbSize,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: TSize.spaceBetweenItemsHorizontal),
            SizedBox(
              height: TSize.imageThumbSize,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${restaurant?.basicInfo?.name}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  Text(
                    "${restaurant?.basicInfo?.address}"
                  ),

                  Row(
                    children: [
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      //   decoration: BoxDecoration(
                      //     color: Colors.orange.withOpacity(0.2),
                      //     borderRadius: BorderRadius.circular(TSize.borderRadiusSm),
                      //   ),
                      //   child: Text(
                      //     "20% discount",
                      //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TColor.star),
                      //   ),
                      // ),

                      Text(
                        "£${restaurant?.avgPrice} (per Dish)",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class RestaurantCartCardSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: TSize.sm,
            horizontal: TDeviceUtil.getScreenWidth() * 0.05,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20000),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoxSkeleton(
                height: TSize.imageThumbSize,
                width: TSize.imageThumbSize,
                borderRadius: TSize.borderRadiusMd,
              ),
              SizedBox(width: TSize.spaceBetweenItemsHorizontal),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoxSkeleton(
                      height: 18,
                      width: double.infinity,
                    ),
                    SizedBox(height: 8),
                    BoxSkeleton(
                      height: 12,
                      width: double.infinity,
                    ),
                    SizedBox(height: 8),
                    BoxSkeleton(
                      height: 18,
                      width: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SeparateSectionBar(),

      ],
    );
  }
}