import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar/delivery_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/round_icon_button.dart';
import 'package:food_delivery_app/common/widgets/cards/food_card.dart';
import 'package:food_delivery_app/common/widgets/list/food_list.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/common/widgets/skeleton/skeleton_list.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_basket_controller.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RestaurantBasket extends StatelessWidget {
  final double? height;
  const RestaurantBasket({
    this.height,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantBasketController>(
      init: RestaurantBasketController(),
      builder: (controller) {
        return Obx(() =>
          SizedBox(
          height: height,
          child: Scaffold(
            body:
            (controller.isLoading.value)
            ? buildSkeleton(context)
            : Column(
              children: [
                MainWrapper(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Icon(
                          TIcon.delete,
                          color: TColor.primary,
                          size: TSize.iconLg,
                        ),
                      ),

                      Expanded(
                        child: Text(
                          "Cart",
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),

                      InkWell(
                        onTap: () {Get.back();},
                        child: Icon(
                          Icons.close,
                          color: TColor.primary,
                          size: TSize.iconLg,
                        ),
                      ),
                    ],
                  ),
                ),
                SeparateBar(direction: Direction.horizontal, space: true,),

                Expanded(
                  child: SingleChildScrollView(
                    child: Obx(() => Column(
                      children: [
                        for(var cartDish in controller.cartDishes ?? [])...[
                          FoodCard(
                            dish: cartDish?.dish,
                            type: FoodCardType.list,
                            removePressed: () => controller.removeFromCart(),
                            addPressed: () => controller.addToCart(),
                          ),
                          SeparateBar(direction: Direction.horizontal,)
                        ]
                      ],
                    ),
                  )),
                )
              ],
            ),
            bottomNavigationBar: DeliveryBottomNavigationBar(),
          ),
        ));
      },
    );
  }

  Widget buildSkeleton(BuildContext context) {
    return Column(
      children: [
        MainWrapper(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for(int i = 0; i < 3; i++)...[
                BoxSkeleton(height: 25, width: 40)
              ]
            ],
          ),
        ),
        SeparateBar(direction: Direction.horizontal, space: true),


        Expanded(
          child: SkeletonList(
            skeleton: FoodCardListSkeleton(),
            separate: SeparateBar(direction: Direction.horizontal, space: true),
          ),
        ),
      ],
    );
  }
}
