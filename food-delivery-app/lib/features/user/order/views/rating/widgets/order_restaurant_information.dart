import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/user/food/views/restaurant/restaurant_detail.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class OrderRestaurantInformation extends StatelessWidget {
  final String? head;
  final Restaurant? restaurant;

  const OrderRestaurantInformation({
    this.head,
    this.restaurant,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${head ?? ""}",
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: TSize.spaceBetweenSections),

        // Image.asset(
        //   TImage.hcBurger1
        // ),

        InkWell(
          onTap: () {
            Get.to(() => RestaurantDetailView(), arguments: {
              'id': restaurant?.id
            });
          },
          child: THelperFunction.getValidImage(
            restaurant?.detailInfo?.coverImage
          ),
        ),
        SizedBox(height: TSize.spaceBetweenItemsVertical),
        Text(
          '${restaurant?.basicInfo?.name}',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary),
        ),

      ],
    );
  }
}
