import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/animation/text_with_dot_animation.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/dialogs/show_confirm_dialog.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/socket_services/order_socket_service.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/user/order/controllers/basket/order_basket_controller.dart';
import 'package:food_delivery_app/features/user/order/controllers/history/order_history_detail_controller.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/features/user/order/views/cancel/order_cancel.dart';
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

class DeliveryDetail extends StatefulWidget {
  final Order? order;
  final OrderViewType viewType;

  DeliveryDetail({
    this.order,
    this.viewType = OrderViewType.cancel,
  });

  @override
  State<DeliveryDetail> createState() => _DeliveryDetailState();
}

class _DeliveryDetailState extends State<DeliveryDetail> {
  var controller;

  @override
  Widget build(BuildContext context) {
    if (widget.viewType == OrderViewType.basket) {
      controller = OrderBasketController.instance;
    }
    else if(widget.viewType == OrderViewType.history) {
      controller = OrderHistoryDetailController.instance;
    }

    return MainWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Delivery Address Section
          InkWell(
            onTap: (widget.viewType != OrderViewType.history)
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
                    widget.order?.deliveryAddress?.address ?? "Choose your address",
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
              _buildRow(context, "Subtotal", "£ ${widget.order?.totalPrice.toStringAsFixed(2)}"),
              _buildRow(context, "Delivery Fee" , "£ ${widget.order?.deliveryFee.toStringAsFixed(2)}"),
              _buildRow(context, "Discount", "- £ ${widget.order?.discount.toStringAsFixed(2)}"),
              Divider(),
              _buildRow(context, "Total", "£ ${widget.order?.total.toStringAsFixed(2)}"),
            ],
          ),

          SizedBox(height: TSize.spaceBetweenSections),

          // Review or Cancellation Section
          if (widget.viewType == OrderViewType.history && widget.order?.status == "COMPLETED") _buildReviewSection(context),
          if ((widget.viewType == OrderViewType.history && widget.order?.status == "CANCELLED") ||
              widget.order?.cancellation != null) _buildCancellationSection(context, widget.order?.cancellation?.reason),

          SizedBox(height: TSize.spaceBetweenSections),

          // Action Buttons
          Row(
            children: [
              if (widget.viewType == OrderViewType.history && widget.order?.status == "COMPLETED")...[
                Expanded(
                  child: MainButton(
                    onPressed: () {},
                    text: "Reorder",
                    prefixIconStr: TIcon.fillCart,
                    backgroundColor: TColor.secondary,
                    borderColor: TColor.secondary,
                    textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.light),
                  ),
                ),
                SizedBox(width: TSize.spaceBetweenItemsVertical),

              ],
              if (widget.viewType == OrderViewType.history && widget.order?.status == "ACTIVE" && (widget.order?.cancellation == null))...[
                Expanded(
                  child: InkWell(onTap: () async {
                    await Get.to(() => OrderCancelView());
                    await controller.initialize(); // From OrderHistoryDetailController
                  },
                    child: Text(
                      "Cancel Order",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.textDesc),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: TSize.spaceBetweenItemsVertical),
              ],
              if(widget.viewType == OrderViewType.history && widget.order?.status == "ACTIVE" && (widget.order?.cancellation == null))...[
                Expanded(
                  // width: TDeviceUtil.getScreenWidth() * 0.45,
                  child: MainButton(
                    paddingHorizontal: TSize.lg,
                    onPressed: () async {
                      void onAccept() async {
                        final [statusCode, headers, data] = await APIService<Order>(
                          endpoint: 'order/order/${widget.order?.id}/create-delivery-and-request',
                        ).create({}, noBearer: true, noFromJson: true);
                        final delivery = Delivery.fromJson(data["delivery"]);
                        final nearestDeliverer = Deliverer.fromJson(data["nearest_deliverer"]);
                        $print(nearestDeliverer);
                        Get.to(() => OrderTrackingView(), arguments: {
                          'id': delivery.order.id,
                        });
                      }
                      onAccept();
                    },
                    text: "Track Order",
                    textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.light),
                  ),
                ),
              ],
              if(widget.order?.status == "PENDING")...[
                Expanded(
                  // width: TDeviceUtil.getScreenWidth() * 0.45,
                  child: MainButton(
                    paddingHorizontal: TSize.lg,
                    onPressed: () async {
                      void onAccept() async {
                        final [statusCode, headers, data] = await APIService<Order>(
                          endpoint: 'order/order/${widget.order?.id}/create-delivery-and-request',
                        ).create({}, noBearer: true, noFromJson: true);
                        final delivery = Delivery.fromJson(data["delivery"]);
                        final nearestDeliverer = Deliverer.fromJson(data["nearest_deliverer"]);
                        $print(nearestDeliverer);
                        Get.to(() => OrderTrackingView(), arguments: {
                          'id': delivery.order.id,
                        });
                      }
                      showConfirmDialog(context, onAccept: onAccept,
                        title: "Are you sure ?",
                        description: "Check the information carefully ",
                      );
                    },
                    text: "Order",
                    textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.light),
                  ),
                ),
              ],
              if(widget.order?.cancellation != null)...[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Color(0xfffbc972),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextWithDotAnimation(
                      text: "Waiting for response",
                    ),
                  ),
                )
              ]

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

  Widget _buildCancellationSection(BuildContext context, String? reason) {
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
          onTap: () async {
            await Get.to(() => OrderCancelView());
            await controller.initialize(); // From OrderHistoryDetailController
          },
          icon: Icons.edit,
          iconColor: TColor.light,
          backgroundColor: TColor.primary,
        ),

        CircleIconCard(
          onTap: () {
            showConfirmDialog(context, onAccept: () async {
              if(widget.order?.id != null) {
                $print("DELETE");
                await APIService<OrderCancellation>().delete(widget.order?.id ?? '');
              }
              else {
                $print("NO ACTION");
              }
              await controller.initialize(); // From OrderHistoryDetailController

            },
              title: "Are you sure to continue the order ?",
              description: "Check information carefully",
            );
          },
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
