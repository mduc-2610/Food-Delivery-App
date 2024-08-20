import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/controllers/card/food_card_controller.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/round_icon_button.dart';
import 'package:food_delivery_app/common/widgets/misc/icon_or_svg.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/views/detail/food_detail.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

enum FoodCardType { grid, list }

class FoodCard extends StatefulWidget {
  final FoodCardType type;
  final Dish? dish;
  final User? user;
  final void Function()? addPressed;
  final void Function()? removePressed;

  const FoodCard({
    required this.type,
    this.dish,
    this.user,
    this.addPressed,
    this.removePressed,
    super.key,
  });

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  late final controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(FoodCardController(widget.dish), tag: widget.dish?.id.toString());
  }

  @override
  Widget build(BuildContext context) {

    if (widget.type == FoodCardType.grid) {
      return _buildGridCard(context);
    } else {
      return _buildListCard(context);
    }
  }

  Widget _buildGridCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(FoodDetailView(), arguments: {
          'id': widget.dish?.id
        });
      },
      child: Card(
        elevation: TSize.cardElevation,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(TSize.sm + 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(TSize.sm),
                    child: Image.asset(
                      "${TImage.hcBurger1 ?? widget.dish?.image}",
                      width: double.infinity,
                      // height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: TSize.sm,
                    right: TSize.sm,
                    child: InkWell(
                      onTap: controller.handleLike,
                      child: Container(
                        padding: EdgeInsets.all(TSize.sm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(TSize.borderRadiusCircle),
                        ),
                        child: SvgPicture.asset(
                          TIcon.heart,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: TSize.xs),
              Text(
                "${widget.dish?.name ?? "Burger"}",
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: TSize.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(TIcon.fillStar),
                  SizedBox(width: TSize.spaceBetweenItemsSm),
                  Text(
                    "${widget.dish?.rating ?? 0}",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.star),
                  ),
                  SizedBox(width: TSize.spaceBetweenItemsSm),
                  SeparateBar(),
                  SizedBox(width: TSize.spaceBetweenItemsSm),
                  Icon(
                    Icons.thumb_up,
                    size: TSize.iconSm,
                    color: TColor.primary,
                  ),
                  SizedBox(width: TSize.spaceBetweenItemsSm),
                  Text(
                    "${widget.dish?.totalLikes ?? 0}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "£${widget.dish?.originalPrice ?? 0}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                  Text(
                      "${controller.restaurantDetailController.mapDishQuantity[widget.dish?.id]}"
                  ),
                  RoundIconButton(
                    onPressed: controller.handleAddToCart,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(FoodDetailView(), arguments: {
          'id': widget.dish?.id
        });
      },
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
                    "${TImage.hcBurger1 ?? widget.dish?.image}",
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
                        "${widget.dish?.name ?? "Burger"}",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      // SizedBox(height: TSize.spaceBetweenItemsSm),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(TIcon.fillStar),
                          SizedBox(width: TSize.spaceBetweenItemsSm),
                          Text(
                            "${widget.dish?.rating ?? 0}",
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
                            "${widget.dish?.totalLikes ?? 0}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsSm),

                      Row(
                        children: [
                          Text(
                            "£${widget.dish?.originalPrice ?? 0}",
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
                            "£${widget.dish?.discountPrice ?? 0}",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                          ),
                          Spacer(),

                          Obx(() => (controller.restaurantDetailController.mapDishQuantity[widget.dish?.id] != null) ?
                          Row(
                            children: [
                              RoundIconButton(
                                onPressed: () => controller.handleRemoveFromCart(extra: widget.removePressed),
                                backgroundColor: Colors.transparent,
                                icon: TIcon.remove,
                                iconColor: TColor.primary,
                              ),
                              SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                              // Obx(() =>
                              Text(
                                  "${controller.restaurantDetailController.mapDishQuantity[widget.dish?.id]}"
                              ),
                            ],
                          )

                              : SizedBox.shrink()),
                          SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                          RoundIconButton(
                            onPressed: () => controller.handleAddToCart(extra: widget.addPressed),
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
      ),
    );
  }
}

class FoodCardGridSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: TSize.cardElevation,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(TSize.sm + 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(TSize.sm),
                  child: BoxSkeleton(
                    height: 120,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: TSize.sm,
                  right: TSize.sm,
                  child: BoxSkeleton(
                    height: 24,
                    width: 24,
                    borderRadius: TSize.borderRadiusCircle,
                  ),
                ),
              ],
            ),
            SizedBox(height: TSize.xs),
            BoxSkeleton(
              height: 20,
              width: 100,
            ),
            SizedBox(height: TSize.xs),
            Row(
              children: [
                BoxSkeleton(
                  height: 20,
                  width: 60,
                ),
                Spacer(),
                BoxSkeleton(
                  height: 20,
                  width: 40,
                ),
              ],
            ),
            SizedBox(height: TSize.xs),
            Row(
              children: [
                BoxSkeleton(
                  height: 20,
                  width: 40,
                ),
                Spacer(),
                BoxSkeleton(
                  height: 20,
                  width: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FoodCardListSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: BoxSkeleton(
                  height: TSize.imageThumbSize + 30,
                  width: TSize.imageThumbSize + 30,
                ),
              ),
              SizedBox(width: TSize.spaceBetweenItemsHorizontal),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoxSkeleton(
                      height: 20,
                      width: 150,
                    ),
                    SizedBox(height: TSize.spaceBetweenItemsSm),
                    Row(
                      children: [
                        BoxSkeleton(
                          height: 20,
                          width: 60,
                        ),
                        Spacer(),
                        BoxSkeleton(
                          height: 20,
                          width: 40,
                        ),
                      ],
                    ),
                    SizedBox(height: TSize.spaceBetweenItemsSm),
                    Row(
                      children: [
                        BoxSkeleton(
                          height: 20,
                          width: 40,
                        ),
                        Spacer(),
                        BoxSkeleton(
                          height: 20,
                          width: 40,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
