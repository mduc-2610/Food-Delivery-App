import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar/delivery_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/round_icon_button.dart';
import 'package:food_delivery_app/features/user/food/controllers/detail/food_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/views/review/skeleton/detail_review_skeleton.dart';
import 'package:food_delivery_app/features/user/food/views/detail/widgets/food_detail_sliver_app_bar.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class FoodDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodDetailController>(
      init: FoodDetailController(),
      builder: (controller) {
        final dish = controller.dish;

        return
          Obx(() =>
          (controller.isLoading.value)
              ? DetailViewSkeleton()
              : Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                FoodDetailSliverAppBar(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${dish?.name}",
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Text(
                                        "£${dish?.discountPrice}",
                                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: TColor.textDesc),
                                      ),
                                      Positioned(
                                        bottom: 7,
                                        child: SizedBox(
                                          width: 100,
                                          child: Divider(
                                            thickness: 3,
                                            color: TColor.textDesc,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: TSize.spaceBetweenItemsVertical),
                                  Text(
                                    "£${dish?.originalPrice}",
                                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: TColor.primary),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: TSize.spaceBetweenItemsVertical),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(() => (controller.restaurantDetailController.mapDishQuantity[dish?.id] != null) ?
                                Row(
                                  children: [
                                    RoundIconButton(
                                      onPressed: controller.handleRemoveFromCart,
                                      backgroundColor: Colors.transparent,
                                      icon: TIcon.remove,
                                      iconColor: TColor.primary,
                                    ),
                                    SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                                    // Obx(() =>
                                    Text(
                                        "${controller.restaurantDetailController.mapDishQuantity[dish?.id]}"
                                    ),
                                  ],
                                )

                                    : SizedBox.shrink()),
                                SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                                RoundIconButton(
                                  onPressed: controller.handleAddToCart,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: TSize.spaceBetweenItemsVertical),
                        Row(
                          children: [
                            SvgPicture.asset(
                              TIcon.fillStar,
                              width: TSize.iconSm,
                              height: TSize.iconSm,
                            ),
                            Text(
                              ' ${dish?.rating} ',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.star),
                            ),
                            Text(
                              '(${dish?.totalReviews} reviews)',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: controller.getToFoodReview,
                              child: Text(
                                "See all reviews",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: TSize.spaceBetweenItemsVertical),
                        Text(
                          '${dish?.description}',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(height: TSize.spaceBetweenItemsVertical),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "See all",
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),

                        SizedBox(height: TSize.spaceBetweenItemsVertical),
                        Text(
                          'Additional Options:',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: TSize.spaceBetweenItemsVertical),
                        _buildOptionRow("Add Cheese", "+ £0.50", controller),
                        _buildOptionRow("Add Bacon", "+ £0.50", controller),
                        _buildOptionRow("Add Meat", "+ £0.50", controller),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: SingleChildScrollView(
                child: Column(
                  children: [
                    DeliveryBottomNavigationBar()
                  ],
                )
            ),
          )
          );
      },
    );
  }

  Widget _buildOptionRow(String text, String price, FoodDetailController controller) {
    bool selected = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        Row(
          children: [
            Text(price),
            Checkbox(
              onChanged: (e) {
                selected = e!;
                // Update the UI and state if necessary
              },
              value: selected,
            ),
          ],
        ),
      ],
    );
  }
}
