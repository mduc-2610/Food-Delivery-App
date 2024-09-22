import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_bar.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';

class RestaurantFoodCard extends StatelessWidget {
  final Dish? dish;

  const RestaurantFoodCard({
    this.dish,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: TDeviceUtil.getScreenWidth(),
        child: Card(
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
                    "${TImage.hcBurger1 ?? dish?.image}",
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
                        "${dish?.name ?? "Burger"}",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(TIcon.fillStar),
                          SizedBox(width: TSize.spaceBetweenItemsSm),
                          Text(
                            "${dish?.rating ?? 0}",
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
                            "${dish?.totalLikes ?? 0}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsSm),

                      Row(
                        children: [
                          Text(
                            "£${dish?.originalPrice ?? 0}",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: TColor.textDesc,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 2,
                                decorationColor: TColor.textDesc
                            ),
                          ),
                        ],
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "£${dish?.discountPrice ?? 0}",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                          ),
                          Spacer(),

                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
