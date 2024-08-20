import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/controllers/card/food_card_controller.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/buttons/round_icon_button.dart';
import 'package:food_delivery_app/common/widgets/list/food_list.dart';
import 'package:food_delivery_app/common/widgets/misc/icon_or_svg.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_dish_option_controller.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RestaurantDishOption extends StatefulWidget {
  final Dish? dish;
  RestaurantDishOption({this.dish});
  @override
  _RestaurantDishOptionState createState() => _RestaurantDishOptionState();
}

class _RestaurantDishOptionState extends State<RestaurantDishOption> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantDishOptionController>(
      init: RestaurantDishOptionController(widget.dish?.id),
      builder: (controller) {
        return
          SizedBox(
            height: TDeviceUtil.getScreenHeight() * 3 / 4,
            child: controller.isLoading.value
            ? buildSkeletonLoading(context)
            : Scaffold(
            body: Column(
              children: [
                Column(
                  children: [
                    Text(
                      "Choose your option",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: TColor.primary
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: TDeviceUtil.getScreenWidth(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(TSize.borderRadiusLg),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(TSize.borderRadiusMd),
                              child: Image.asset(
                                "${TImage.hcBurger1 ?? controller.dish?.image}",
                                width: TSize.imageThumbSize + 30,
                                height: TSize.imageThumbSize + 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${controller.dish?.name ?? "Burger"}",
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                  Text(
                                    "${controller.dish?.description ?? "Burger"}",
                                    style: Theme.of(context).textTheme.bodySmall,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(TIcon.fillStar),
                                      SizedBox(width: TSize.spaceBetweenItemsSm),
                                      Text(
                                        "${controller.dish?.rating ?? 0}",
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.star),
                                      ),
                                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                                      SeparateBar(),
                                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                                      Icon(
                                        Icons.thumb_up,
                                        size: TSize.iconSm,
                                        color: TColor.primary,
                                      ),
                                      SizedBox(width: TSize.spaceBetweenItemsSm),
                                      Text(
                                        "${controller.dish?.totalLikes ?? 0}",
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: TSize.spaceBetweenItemsSm),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "£${controller.dish?.originalPrice ?? 0}",
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            color: TColor.textDesc,
                                            decoration: TextDecoration.lineThrough,
                                            decorationThickness: 2,
                                            decorationColor: TColor.textDesc
                                        ),
                                      ),
                                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                                      Text(
                                        "£${controller.dish?.discountPrice ?? 0}",
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                                      ),
                                      Spacer(),

                                      SizedBox(width: TSize.spaceBetweenItemsLg),
                                      Row(
                                        children: [
                                          RoundIconButton(
                                            onPressed: controller.foodCardController.handleRemoveFromCart,
                                            backgroundColor: Colors.transparent,
                                            icon: TIcon.remove,
                                            iconColor: TColor.primary,
                                          ),
                                          SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                                          // Obx(() =>
                                          Obx(() => Text(
                                              "${controller.restaurantDetailController.mapDishQuantity[controller.dish?.id]}"
                                          ),)
                                        ],
                                      ),
                                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                                      RoundIconButton(
                                        onPressed: controller.foodCardController.handleAddToCart,
                                      )
                                    ],
                                  )

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product image and details
                        for(var option in controller.dish?.options ?? [])...[
                          Column(
                            children: [
                              Container(
                                color: TColor.textDesc,
                                child: ListTile(
                                  title: MainWrapper(child: Text('${option.formattedName}')),
                                ),
                              ),
                              for(var item in option.items ?? [])...[
                                Obx(() => CheckboxListTile(
                                  title: MainWrapper(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${item.name}"),
                                        Text('${item.price}'),
                                      ],
                                    ),
                                  ),
                                  value: controller.mapItemChosen[option.name]?[item?.id] ?? false,
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      if (option.name == 'sizes') {
                                        controller.mapItemChosen[option.name]?.updateAll((key, _) => false);
                                      }
                                      controller.mapItemChosen[option.name]?[item?.id] = value;
                                      controller.mapItemChosen.refresh();
                                    }

                                    print(controller.mapItemChosen[option.name]?[item?.id]);
                                  },
                                )),
                                SeparateBar(direction: Direction.horizontal, color: TColor.borderPrimary,),
                              ]
                            ],
                          )
                        ]
                      ],
                    ),
                  ),
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

              ],
            ),
            bottomNavigationBar: SingleChildScrollView(
              child: MainWrapper(
                bottomMargin: TSize.spaceBetweenItemsVertical,
                child: MainButton(
                  onPressed: () {},
                  text: "Add to cart - 26.000đ",
                ),
              ),
            ),
                    ),
          );
      },
    );
  }

  Widget buildSkeletonLoading(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            BoxSkeleton(height: 24, width: 200),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            Container(
              width: TDeviceUtil.getScreenWidth(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BoxSkeleton(
                      height: TSize.imageThumbSize + 30,
                      width: TSize.imageThumbSize + 30,
                      borderRadius: TSize.borderRadiusMd,
                    ),
                    SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BoxSkeleton(height: 24, width: 150),
                          SizedBox(height: TSize.spaceBetweenItemsSm),
                          BoxSkeleton(height: 16, width: 200),
                          SizedBox(height: TSize.spaceBetweenItemsSm),
                          Row(
                            children: [
                              BoxSkeleton(height: 16, width: 80),
                              Spacer(),
                              BoxSkeleton(height: 24, width: 100),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(3, (index) =>
                  Column(
                    children: [
                      BoxSkeleton(height: 48, width: double.infinity),
                      SizedBox(height:  TSize.spaceBetweenItemsVertical),

                      ...List.generate(3, (index) =>
                          MainWrapper(
                            bottomMargin: TSize.spaceBetweenItemsVertical,
                            child: Row(
                              children: [
                                Expanded(child: BoxSkeleton(height: 24, width: double.infinity)),
                                SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                                BoxSkeleton(height: 24, width: 24, borderRadius: TSize.borderRadiusSm,),
                              ],
                            ),
                          )
                      ),
                    ],
                  )
              ),
            ),
          ),
        ),
      ],
    );
  }
}