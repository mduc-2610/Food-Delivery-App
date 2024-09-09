import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/user/order/controllers/basket/order_basket_controller.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/order_info.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';


class OrderCard extends StatefulWidget {
  final RestaurantCartDish cartDish;
  final bool noMargin;
  final bool isCompletedOrder;
  final bool canEdit;

  OrderCard({
    required this.cartDish,
    this.noMargin = false,
    this.isCompletedOrder = true,
    this.canEdit = true,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {

  @override
  Widget build(BuildContext context) {
    var _controller;
    bool canEdit = widget.canEdit;
    if(canEdit) {
      _controller = OrderBasketController.instance;
    }
    return MainWrapper(
      noMargin: widget.noMargin,
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
                              "${widget.cartDish.dish?.name}",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Text(
                                  '£${widget.cartDish.price.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                                Text(
                                  '£${widget.cartDish.dish?.discountPrice?.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                                ),
                              ],
                            ),
                            SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                            Row(
                              children: [
                                CircleIconCard(
                                  onTap: (canEdit)
                                      ? () => _controller.foodListController.handleCartUpdate(dishId: widget.cartDish.dish?.id ?? '', quantity: -1)
                                      : null,
                                  icon: Icons.remove,
                                  iconColor: TColor.primary,
                                  borderSideWidth: 1,
                                  borderSideColor: TColor.primary,
                                  iconSize: TSize.iconSm,
                                ),
                                SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                                (canEdit)
                                ? Obx(() => Text(
                                  "${_controller.restaurantDetailController.mapDishQuantity[widget.cartDish.dish?.id] ?? 0}",
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ))
                                : Text(
                                  "${widget.cartDish.quantity}",
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                                SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                                CircleIconCard(
                                  onTap: (canEdit)
                                    ? () => _controller.foodListController.handleCartUpdate(dishId: widget.cartDish.dish?.id ?? '', quantity: 1)
                                    : null,
                                  icon: Icons.add,
                                  iconColor: TColor.primary,
                                  borderSideWidth: 1,
                                  borderSideColor: TColor.primary,
                                  iconSize: TSize.iconSm,
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

              // if (options != null) ...[
              //   Column(
              //     children: [
              //       SizedBox(height: TSize.spaceBetweenItemsVertical,),
              //
              //       Divider(
              //         thickness: 1,
              //       ),
              //       SizedBox(height: TSize.spaceBetweenItemsVertical,),
              //
              //       ...options!.map((extra) => Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             extra.split(':')[0],
              //             style: Theme.of(context).textTheme.bodyMedium,
              //           ),
              //
              //           Text(
              //             extra.split(':')[1],
              //             style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: TColor.primary),
              //           )
              //         ],
              //       )),
              //     ],
              //   )
              // ],
            ],
          ),
        ),
      ),
    );
  }
}

class OrderCardSkeleton extends StatelessWidget {
  const OrderCardSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: TSize.md,
          horizontal: TSize.md,
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
                    BoxSkeleton(
                      height: 80,
                      width: 80,
                      borderRadius: TSize.sm,
                    ),
                    SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BoxSkeleton(
                            height: 20,
                            width: double.infinity,
                            borderRadius: TSize.sm,
                          ),
                          SizedBox(height: TSize.spaceBetweenItemsHorizontal),
                          Row(
                            children: [
                              BoxSkeleton(
                                height: 16,
                                width: 60,
                                borderRadius: TSize.sm,
                              ),
                              SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                              BoxSkeleton(
                                height: 16,
                                width: 60,
                                borderRadius: TSize.sm,
                              ),
                            ],
                          ),
                          SizedBox(height: TSize.spaceBetweenItemsHorizontal),
                          Row(
                            children: [
                              BoxSkeleton(
                                height: 24,
                                width: 24,
                                borderRadius: TSize.sm,
                              ),
                              SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                              BoxSkeleton(
                                height: 24,
                                width: 24,
                                borderRadius: TSize.sm,
                              ),
                              SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                              BoxSkeleton(
                                height: 24,
                                width: 24,
                                borderRadius: TSize.sm,
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
                    BoxSkeleton(
                      height: 24,
                      width: 24,
                      borderRadius: TSize.sm,
                    ),
                    SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                    BoxSkeleton(
                      height: 24,
                      width: 24,
                      borderRadius: TSize.sm,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

