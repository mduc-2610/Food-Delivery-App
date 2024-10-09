import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_bar.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/views/restaurant/restaurant_detail.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';


class RestaurantCard extends StatelessWidget {
  final Restaurant? restaurant;
  final int dishPageSize;
  final String? category;

  const RestaurantCard({
    this.restaurant,
    this.dishPageSize = 3,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    List<Dish> dishes = restaurant?.dishes ?? [];
    // if(category != null) {
    //   for(var dish in restaurant?.dishes) {
    //     // $print("cat ${restaurant?.basicInfo?.name} --- ${dish?.name} --- ${dish?.category?.name}  ---  ${category}");
    //   }
    //   dishes = restaurant?.dishes?.where((dish) => dish?.category?.name == category).toList() ?? [];
    // }
    // else {
    //   dishes = restaurant?.dishes ?? [];
    // }
    // if (dishes.isEmpty) {
    //   dishes == restaurant?.dishes;
    // $print("ssslength ${dishes.length}");
    // }
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
              child:
              (dishes.isNotEmpty && dishes[0].image != null)
                  ? Image.network(
                "${dishes[0].image}",
                width: TSize.imageThumbSize,
                height: TSize.imageThumbSize,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                "${TImage.hcBurger1}",
                width: TSize.imageThumbSize,
                height: TSize.imageThumbSize,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: TSize.spaceBetweenItemsHorizontal),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${restaurant?.basicInfo?.name}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsSm),

                  Row(
                    children: [
                      SvgPicture.asset(
                          TIcon.fillStar
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsSm),
                      Text(
                        "${restaurant?.rating}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                      SeparateBar(width: 1, height: 15,),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                      Text(
                        "2.6km",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                      SeparateBar(width: 1, height: 15,),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                      Text(
                        "30min",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsSm,),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(TSize.borderRadiusSm),
                    ),
                    child: Text(
                      "20% discount",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TColor.star),
                    ),
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),

                  for(int i = 1; i < min(dishes.length, dishPageSize); i++)...[
                    Container(
                      height: 80,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(TSize.borderRadiusMd),
                            child:
                            (dishes[i].image != null)
                            ? Image.network(
                              "${dishes[i].image}",
                              width: TSize.imageThumbSize,
                              height: TSize.imageThumbSize,
                              fit: BoxFit.cover,
                            )
                            : Image.asset(
                              "${TImage.hcBurger1}",
                              width: TSize.imageThumbSize,
                              height: TSize.imageThumbSize,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${dishes[i].name}",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  "${dishes[i].originalPrice}",
                                  style: Theme.of(context).textTheme.titleMedium,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: TSize.spaceBetweenItemsSm + 2,),
                  ]
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}


class RestaurantCardSkeleton extends StatelessWidget {
  const RestaurantCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: TSize.sm,
        horizontal: TSize.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                BoxSkeleton(
                  height: 20,
                  width: 150,
                  borderRadius: TSize.borderRadiusMd,
                ),
                SizedBox(height: TSize.spaceBetweenItemsSm),
                Row(
                  children: [
                    BoxSkeleton(
                      height: 20,
                      width: 20,
                      borderRadius: TSize.borderRadiusMd,
                    ),
                    SizedBox(width: TSize.spaceBetweenItemsSm),
                    BoxSkeleton(
                      height: 20,
                      width: 50,
                      borderRadius: TSize.borderRadiusMd,
                    ),
                    SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                    BoxSkeleton(
                      height: 20,
                      width: 50,
                      borderRadius: TSize.borderRadiusMd,
                    ),
                    SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                    BoxSkeleton(
                      height: 20,
                      width: 50,
                      borderRadius: TSize.borderRadiusMd,
                    ),
                  ],
                ),
                SizedBox(height: TSize.spaceBetweenItemsSm),
                BoxSkeleton(
                  height: 20,
                  width: 100,
                  borderRadius: TSize.borderRadiusMd,
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),
                Column(
                  children: List.generate(2, (index) {
                    return Column(
                      children: [
                        Container(
                          height: 80,
                          child: Row(
                            children: [
                              BoxSkeleton(
                                height: TSize.imageThumbSize,
                                width: TSize.imageThumbSize,
                                borderRadius: TSize.borderRadiusMd,
                              ),
                              SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    BoxSkeleton(
                                      height: 20,
                                      width: 100,
                                      borderRadius: TSize.borderRadiusMd,
                                    ),
                                    BoxSkeleton(
                                      height: 20,
                                      width: 50,
                                      borderRadius: TSize.borderRadiusMd,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: TSize.spaceBetweenItemsSm + 2),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );;
  }
}
