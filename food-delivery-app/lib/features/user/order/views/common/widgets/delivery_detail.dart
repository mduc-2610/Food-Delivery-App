import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/dialogs/show_confirm_dialog.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/socket_services/order_socket_service.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/user/order/controllers/basket/order_basket_controller.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/features/user/order/views/location/order_location.dart';
import 'package:food_delivery_app/features/user/order/views/tracking/order_tracking.dart';
import 'package:food_delivery_app/utils/constants/api_constants.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:get/get.dart';

enum OrderViewType { basket, history, cancel, other }

class DeliveryDetail extends StatelessWidget {
  final Order? order;
  final OrderViewType viewType;

  DeliveryDetail({
    this.order,
    this.viewType = OrderViewType.cancel,
  });

  @override
  Widget build(BuildContext context) {
    $print("aaaaa${order}");
    var controller;
    if (viewType != OrderViewType.history) {
      controller = OrderBasketController.instance;
    }

    return MainWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Delivery Address Section
          InkWell(
            onTap: (viewType != OrderViewType.history)
                ? () async {
              await Get.to(() => OrderLocationSelectView());
              await controller.initializeUser();
            }
                : null,
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
                    order?.deliveryAddress?.address ?? "Choose your address",
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
                      Icon(TIcon.promotion, color: TColor.primary),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                      Text("Promotions"),
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsSm),
                  Text(
                    "Free shipping 20%",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: TSize.spaceBetweenSections),

          // Price Breakdown Section
          Column(
            children: [
              _buildRow(context, "Subtotal", "£ ${order?.totalPrice.toStringAsFixed(2)}"),
              _buildRow(context, "Delivery Fee" , "£ ${order?.deliveryFee.toStringAsFixed(2)}"),
              _buildRow(context, "Discount", "- £ ${order?.discount.toStringAsFixed(2)}"),
              Divider(),
              _buildRow(context, "Total", "£ ${order?.total.toStringAsFixed(2)}"),
            ],
          ),

          SizedBox(height: TSize.spaceBetweenSections),

          // Review or Cancellation Section
          if (viewType == OrderViewType.basket) _buildReviewSection(context),
          if (viewType != OrderViewType.basket) _buildCancellationSection(context),

          SizedBox(height: TSize.spaceBetweenSections),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (viewType == OrderViewType.basket)
                MainButton(
                  onPressed: () {},
                  text: "Reorder",
                  prefixIconStr: TIcon.fillCart,
                  textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.light),
                ),
              if (viewType != OrderViewType.basket)
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Cancel Order",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.textDesc),
                  ),
                ),
              SizedBox(width: TSize.spaceBetweenSections),
              SizedBox(
                width: TDeviceUtil.getScreenWidth() * 0.45,
                child: MainButton(
                  paddingHorizontal: TSize.lg,
                  onPressed: () async {
                    showConfirmDialog(context, onAccept: () async {
                      final [statusCode, headers, data] = await APIService<Order>(
                        endpoint: 'order/order/${order?.id}/create-delivery-and-request',
                      ).create({}, noBearer: true, noFromJson: true);
                      final delivery = Delivery.fromJson(data["delivery"]);
                      Get.to(() => OrderTrackingView(), arguments: {
                        'id': delivery.order.id,
                      });
                    });
                  },
                  text: "Track Order",
                  textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.light),
                ),
              ),
            ],
          ),
        ],
      ),
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
    return Column(
      children: [
        RatingBarIndicator(
          itemBuilder: (context, _) => SvgPicture.asset(TIcon.fillStar),
          itemCount: 5,
          itemSize: 70,
          rating: 4,
        ),
        SizedBox(height: TSize.spaceBetweenSections),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Type your review ... ',
            hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(fontSize: TSize.md),
          ),
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 5,
        ),
      ],
    );
  }

  // Cancellation Section
  Widget _buildCancellationSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reason for Cancellation', style: Theme.of(context).textTheme.titleSmall),
              Text('221B Baker Street, London, United Kingdom', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
        CircleIconCard(
          icon: Icons.edit,
          iconColor: TColor.light,
          backgroundColor: TColor.primary,
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
          _buildSkeletonActionButtons(),
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

  Widget _buildSkeletonActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BoxSkeleton(
          height: 40,
          width: 120,
        ),
        SizedBox(width: TSize.spaceBetweenSections),
        BoxSkeleton(
          height: 40,
          width: 180,
        ),
      ],
    );
  }
}
