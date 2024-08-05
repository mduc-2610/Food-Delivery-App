import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';


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
