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

class DeliveryDetail extends StatelessWidget {
  final Order? order;
  final String fromView;

  DeliveryDetail({
    this.order,
    this.fromView = "Cancel",
  });

  @override
  Widget build(BuildContext context) {
    final controller = OrderBasketController.instance;
    return MainWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              DeliveryDetailCard(
                onTap: () async {
                  await Get.to(() => OrderLocationSelectView());
                  await controller.initializeUser();
                },
                icon: TIcon.location,
                title: "Deliver to",
                description: "${order?.deliveryAddress?.address ?? "Choose your address"}",
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              DeliveryDetailCard(
                onTap: () {},
                icon: TIcon.payment,
                title: "Payment method",
                description: "Cash",
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              DeliveryDetailCard(
                onTap: () {},
                icon: TIcon.promotion,
                title: "Promotions",
                description: "Free shipping 20%",
              ),
            ],
          ),
          SizedBox(height: TSize.spaceBetweenSections),
          Column(
            children: [
              DeliveryDetailRow(
                title: "Subtotal",
                value: "£ ${order?.cart?.totalPrice.toStringAsFixed(2)}",
              ),
              DeliveryDetailRow(
                title: "Delivery Fee",
                value: "£ ${order?.deliveryFee.toStringAsFixed(2)}",
              ),
              DeliveryDetailRow(
                title: "Discount",
                value: "- £ ${order?.discount.toStringAsFixed(2)}",
              ),
              Divider(),
              DeliveryDetailRow(
                title: "Total",
                value: "£ ${order?.total.toStringAsFixed(2)}",
              ),
            ],
          ),
          SizedBox(height: TSize.spaceBetweenSections),
          ReviewOrCancellationSection(),
          SizedBox(height: TSize.spaceBetweenSections),
          ActionButtons(
            order: order,
            fromView: fromView,
          ),
        ],
      ),
    );
  }
}

class DeliveryDetailCard extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final String description;

  DeliveryDetailCard({
    required this.onTap,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                Icon(icon, color: TColor.primary),
                SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                Text(title),
              ],
            ),
            SizedBox(height: TSize.spaceBetweenItemsSm,),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class DeliveryDetailRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  DeliveryDetailRow({
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: valueColor ?? TColor.primary),
        ),
      ],
    );
  }
}

class ReviewOrCancellationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isReviewing = false; // You can modify this condition based on your logic

    return isReviewing
        ? Column(
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
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reason for Cancellation',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                '221B Baker Street, London, United Kingdom',
                style: Theme.of(context).textTheme.titleLarge,
              ),
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

class ActionButtons extends StatefulWidget {
  final Order? order;
  final String fromView;

  ActionButtons({
    required this.order,
    required this.fromView,
  });

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  @override
  Widget build(BuildContext context) {
    $print(widget.order?.id);
    bool canReorder = false;
    return canReorder
        ? MainButton(
      onPressed: () {},
      text: "Reorder",
      prefixIconStr: TIcon.fillCart,
      textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.light),
    )
        : Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: TSize.sm + 5, horizontal: TSize.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (widget.fromView == "Basket") ? null : () {},
              child: Text(
                (widget.fromView == "Basket")
                    ? "£ ${widget.order?.total.toStringAsFixed(2)}"
                    : "Cancel Order",
                style: (widget.fromView == "Basket")
                    ? Theme.of(context).textTheme.headlineSmall
                    : Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.textDesc),
              ),
            ),
            SizedBox(width: TSize.spaceBetweenSections * ((widget.fromView == "Basket") ? 2 : 1)),
            SizedBox(
              width: TDeviceUtil.getScreenWidth() * 0.45,
              child: MainButton(
                paddingHorizontal: TSize.lg,
                onPressed: () async {
                  showConfirmDialog(context, onAccept: () async {
                    final [statusCode, headers, data] = await APIService<Order>(endpoint: 'order/order/${widget.order?.id}/create-delivery-and-request').create({}, noBearer: true, noFromJson: true);
                    final delivery = Delivery.fromJson(data["delivery"]);
                    final nearest_deliverer = Deliverer.fromJson(data["nearest_deliverer"]);
                    Get.to(() => OrderTrackingView(), arguments: {
                      'delivery': delivery,
                      'nearest_deliverer': nearest_deliverer,
                    });
                  });
                  // x.sendMessage(controller.order?.toJson() ?? {});
                },
                text: "Track Order",
                textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.light),
              ),
            ),
          ],
        ),
      ),
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
