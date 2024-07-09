import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';


class OrderCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double originalPrice;
  final double discountedPrice;
  final List<String>? options;
  final int rating;
  final String? review;
  final bool noMargin;
  final bool isCompletedOrder;

  OrderCard({
    required this.imageUrl,
    required this.name,
    required this.originalPrice,
    required this.discountedPrice,
    this.options,
    required this.rating,
    this.review,
    this.noMargin = false,
    this.isCompletedOrder = true,
  });

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      noMargin: noMargin,
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: TSize.md,
              horizontal: TSize.md
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(TSize.sm),
                        child: Image.asset(
                          TImage.hcBurger1,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                      SizedBox(
                        width: TDeviceUtil.getScreenWidth() * 0.33,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '£${originalPrice.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                                Text(
                                  '£${discountedPrice.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                                ),
                              ],
                            ),
                            SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                            Row(
                              children: [
                                CircleIconCard(
                                  icon: Icons.remove,
                                  iconColor: TColor.primary,
                                  borderSideWidth: 1,
                                  borderSideColor: TColor.primary,
                                  iconSize: TSize.iconXs,
                                ),
                                SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                                Text(
                                  '1',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                                SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                                CircleIconCard(
                                  icon: Icons.add,
                                  iconColor: TColor.primary,
                                  borderSideWidth: 1,
                                  borderSideColor: TColor.primary,
                                  iconSize: TSize.iconXs,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      GestureDetector(
                        child: Icon(
                          TIcon.edit
                        ),
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                      GestureDetector(
                        child: Icon(
                            TIcon.delete
                        ),
                      ),
                    ],
                  )
                ],
              ),

              if (options != null) ...[
                Column(
                  children: [
                    SizedBox(height: TSize.spaceBetweenItemsVertical,),

                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(height: TSize.spaceBetweenItemsVertical,),

                    ...options!.map((extra) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          extra.split(':')[0],
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),

                        Text(
                          extra.split(':')[1],
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: TColor.primary),
                        )
                      ],
                    )),
                  ],
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
