import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/features/restaurant/food/controllers/manage/food_manage_controller.dart';
import 'package:food_delivery_app/features/restaurant/food/views/add/widgets/food_add.dart';
import 'package:food_delivery_app/features/restaurant/food/views/detail/food_detail.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RestaurantFoodCard extends StatelessWidget {
  final Dish? dish;
  final Function()? onEdit;
  final Function()? onToggleDisable;

  const RestaurantFoodCard({
    required this.dish,
    this.onEdit,
    this.onToggleDisable,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    // $print(dish?.isDisabled);
    return InkWell(
      onTap: () async {
        Get.to(() => FoodDetailView(), arguments: {
          "id": dish?.id
        });
      },
      child: Container(
        width: TDeviceUtil.getScreenWidth(),
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSize.borderRadiusLg),
              color: dish?.isDisabled == true? Colors.grey[300] : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(TSize.borderRadiusMd),
                      child:
                        THelperFunction.getValidImage(
                          dish?.image,
                          width: TSize.foodImage,
                          height: TSize.foodImage,
                        ),
                    ),
                    if (dish?.isDisabled == true)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          child: Center(
                            child: Text(
                              'DISABLED',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${dish?.name ?? ''}",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(TIcon.fillStar),
                          SizedBox(width: TSize.spaceBetweenItemsSm),
                          Text(
                            "${dish?.rating}",
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
                            "${dish?.totalLikes}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsSm),

                      Row(
                        children: [
                          Icon(Icons.shopping_cart, color: TColor.primary,),
                          Text(
                            "Orders: ${dish?.totalOrders}",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: TColor.primary,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsMd),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "£${dish?.originalPrice}",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: TColor.textDesc,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 2,
                                    decorationColor: TColor.textDesc
                                ),
                              ),
                              SizedBox(width: TSize.spaceBetweenItemsMd),
                              Text(
                                "£${dish?.discountPrice}",
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                              ),
                            ],
                          ),

                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopupMenuButton<String>(
                      icon: CircleIconCard(
                        icon: Icons.more_horiz,
                        // color: TColor.primary,
                      ),
                      onSelected: (String result) {
                        if (result == 'edit') {
                          onEdit?.call();
                        } else if (result == 'toggle') {
                          onToggleDisable?.call();
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          onTap: onToggleDisable,
                          value: 'toggle',
                          child: Text(
                            dish?.isDisabled == true ? 'Enable' : 'Disable',
                            style: Get.theme.textTheme.bodyMedium,
                          ),
                        ),
                        PopupMenuItem<String>(
                          onTap: onEdit,
                          value: 'edit',
                          child: Text(
                            'Edit Information',
                            style: Get.theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: TSize.spaceBetweenItemsMd),
                    StatusChip(
                      status: dish?.isDisabled == false ? "ACTIVE" : "CANCELLED",
                      text: dish?.isDisabled == false ? "ACTIVE" : "DISABLED",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}