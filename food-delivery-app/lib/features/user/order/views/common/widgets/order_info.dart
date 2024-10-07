import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/restaurant/food/views/manage/widgets/promotion_manage_card.dart';
import 'package:food_delivery_app/features/user/order/controllers/common/order_info_controller.dart';
import 'package:food_delivery_app/features/user/order/controllers/history/order_history_detail_controller.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/features/user/order/views/promotion/order_promotion.dart';
import 'package:food_delivery_app/features/user/order/views/rating/order_rating.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderInfo extends StatelessWidget {
  final Order? order;
  final OrderViewType viewType;
  final VoidCallback? onPromotionPressed;

  OrderInfo({
    this.order,
    this.viewType = OrderViewType.cancel,
    this.onPromotionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderInfoController>(
      init: OrderInfoController(order: order, viewType: viewType),
      builder: (controller) {
        $print("RIGHT NA ${order?.restaurantPromotions?.length}");
        return MainWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Address Section
              InkWell(
                onTap: () => controller.onAddressTapped(),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: TSize.sm, horizontal: TSize.md),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: TColor.textDesc),
                    borderRadius: BorderRadius.circular(TSize.borderRadiusMd),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(TIcon.location, color: TColor.primary),
                          SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                          Text("Deliver to"),
                        ],
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsSm),
                      Text(
                        order?.deliveryAddress?.name ?? "Choose your address",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              // Payment Method Section
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: TSize.sm, horizontal: TSize.md),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: TColor.textDesc),
                    borderRadius: BorderRadius.circular(TSize.borderRadiusMd),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(TIcon.payment, color: TColor.primary),
                          SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                          Text("Payment method"),
                        ],
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsSm),
                      Text(
                        "Cash",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              // Promotions Section
              InkWell(
                onTap: onPromotionPressed ?? () {
                  $print("no arguments passed");
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: TSize.sm, horizontal: TSize.md),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: TColor.textDesc),
                    borderRadius: BorderRadius.circular(TSize.borderRadiusMd),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(TIcon.promotion, color: TColor.primary),
                          SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                          Text("Promotions"),
                        ],
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsSm),
                      if(order?.restaurantPromotions.length == 0)...[
                        Text(
                          "Choose your promotion",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ]
                      else...[
                        for(var promotion in order?.restaurantPromotions ?? [])...[
                          PromotionManageCard(
                            promotion: promotion,
                          )
                        ]
                      ]
                    ],
                  ),
                ),
              ),

              SizedBox(height: TSize.spaceBetweenSections),

              // Price Breakdown Section
              Column(
                children: [
                  _buildRow(context, "Subtotal", "£ ${order?.totalPrice.toStringAsFixed(2)}"),
                  _buildRow(context, "Delivery Fee", "£ ${order?.deliveryFee.toStringAsFixed(2)}"),
                  _buildRow(context, "Discount", "- £ ${order?.discount.toStringAsFixed(2)}"),
                  Divider(),
                  _buildRow(context, "Total", "£ ${order?.total.toStringAsFixed(2)}"),
                ],
              ),

              SizedBox(height: TSize.spaceBetweenSections),

              // Review or Cancellation Section
              if (viewType == OrderViewType.history && order?.status == "COMPLETED") _buildReviewSection(context),


              SizedBox(height: TSize.spaceBetweenSections),
            ],
          ),
        );
      },
    );
  }

  // Price Row Widget
  Widget _buildRow(BuildContext context, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.primary)),
      ],
    );
  }

  // Review Section
  Widget _buildReviewSection(BuildContext context) {
    final orderHistoryDetailController = OrderHistoryDetailController.instance;
    return Column(
      children: [
        Stack(
          children: [
            SmallButton(
                onPressed: () async {
                  final result = await Get.to(() => OrderRatingView(), arguments: {
                    "order": order
                  }) as Map<String, dynamic>?;
                    $print(result?["isUpdated"]);
                  if(result != null && result["isUpdated"] == true) {
                    await orderHistoryDetailController.initialize();
                  }
                },
                text: "Rating your order"
            ),
            if(order?.isReviewed == false)...[
              Positioned(
                top: 0,
                right: 0,
                child: SvgPicture.asset(
                  TIcon.notifyDot,
                ),
              )
            ]
          ],
        ),
        // SizedBox(height: TSize.spaceBetweenSections),
        // RatingBarIndicator(
        //   itemBuilder: (context, _) => SvgPicture.asset(TIcon.fillStar),
        //   itemCount: 5,
        //   itemSize: 70,
        //   rating: 4,
        // ),
        // SizedBox(height: TSize.spaceBetweenSections),
        // TextFormField(
        //   decoration: InputDecoration(
        //     hintText: 'Type your review ... ',
        //     hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(fontSize: TSize.md),
        //   ),
        //   style: Theme.of(context).textTheme.titleMedium,
        //   maxLines: 5,
        // ),
      ],
    );
  }

  Widget _buildCancellationSection(BuildContext context, OrderInfoController controller, String? reason) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reason for Cancellation', style: Theme.of(context).textTheme.titleSmall),
              Text('${reason ?? ''}', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
        CircleIconCard(
          onTap: controller.onCancelOrderTapped,
          icon: Icons.edit,
          iconColor: TColor.light,
          backgroundColor: TColor.primary,
        ),

        CircleIconCard(
          onTap: controller.deleteCancelRequest,
          icon: TIcon.delete,
          iconColor: TColor.light,
          backgroundColor: TColor.error,
        ),
      ],
    );
  }
}

class DeliveryDetailSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSize.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Delivery Detail Cards Skeleton
          Column(
            children: [
              _buildSkeletonCard(),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              _buildSkeletonCard(),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              _buildSkeletonCard(),
            ],
          ),
          SizedBox(height: TSize.spaceBetweenSections),
          // Details Rows Skeleton
          Column(
            children: [
              _buildSkeletonRow(),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              _buildSkeletonRow(),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              _buildSkeletonRow(),
              Divider(),
              _buildSkeletonRow(),
            ],
          ),
          SizedBox(height: TSize.spaceBetweenSections),
          // Review or Cancellation Section Skeleton
          _buildSkeletonReviewOrCancellation(),
          SizedBox(height: TSize.spaceBetweenSections),
          // Action Buttons Skeleton
        ],
      ),
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: TSize.sm, horizontal: TSize.md),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(TSize.borderRadiusMd),
      ),
      child: Row(
        children: [
          BoxSkeleton(
            height: 24,
            width: 24,
          ),
          SizedBox(width: TSize.spaceBetweenItemsHorizontal),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoxSkeleton(
                height: 14,
                width: 120,
              ),
              SizedBox(height: TSize.spaceBetweenItemsSm),
              BoxSkeleton(
                height: 14,
                width: 200,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BoxSkeleton(
          height: 14,
          width: 100,
        ),
        BoxSkeleton(
          height: 14,
          width: 80,
        ),
      ],
    );
  }

  Widget _buildSkeletonReviewOrCancellation() {
    return Column(
      children: [
        BoxSkeleton(
          height: 70,
          width: 350,
        ),
        SizedBox(height: TSize.spaceBetweenSections),
        BoxSkeleton(
          height: 100,
          width: double.infinity,
        ),
      ],
    );
  }

}

