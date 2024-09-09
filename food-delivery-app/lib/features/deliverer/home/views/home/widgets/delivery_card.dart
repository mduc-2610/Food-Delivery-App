import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/cards/order_history_card.dart';
import 'package:food_delivery_app/common/widgets/dialogs/show_confirm_dialog.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/deliverer/delivery/controllers/delivery/delivery_controller.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/features/user/order/views/basket/widgets/order_card.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DeliveryCard extends StatelessWidget {
  final DeliveryRequest? deliveryRequest;
  final bool noMargin;
  final Delivery? delivery;

  DeliveryCard({
    Key? key,
    this.deliveryRequest,
    this.noMargin = false,
    Delivery? delivery
  }) : delivery = deliveryRequest?.delivery ?? delivery;


  @override
  Widget build(BuildContext context) {
    final deliveryController = DeliveryController.instance;
    return GestureDetector(
      onTap: () {
        // Get.to(() => DeliveryDetailView(delivery: delivery));
      },
      child: Card(
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: TSize.cardElevation,
        child: Padding(
          padding: EdgeInsets.all(TSize.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDeliveryInfo(context),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              _buildLocationInfo(context),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              _buildStatusAndTimeInfo(context),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              Row(
                children: [
                  if(delivery?.status == "FINDING_DRIVER")...[
                    Expanded(
                      child: SmallButton(
                        paddingVertical: 0,
                        text: "Decline",
                        backgroundColor: TColor.reject,
                        onPressed: () => deliveryController.handleDecline(deliveryRequest),
                      ),
                    ),
                    SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                    Expanded(
                      child: SmallButton(
                        paddingVertical: 0,
                        text: "Accept",
                        onPressed: () => deliveryController.handleAccept(deliveryRequest),
                      )
                    ),
                  ],
                ]
              ),
              SmallButton(
                text: "Check Route",
                backgroundColor: TColor.secondary,
                onPressed: () => deliveryController.handleCheckRoute(deliveryRequest),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryInfo(BuildContext context) {
    return Row(
      children: [
        Icon(
          TIcon.delivery,
          color: TColor.primary,
        ),
        SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

        Expanded(
          child: Text(
            'Delivery ID: ${delivery?.id?.split('-')[0]}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        // Spacer(),
        // if (delivery?.order != null && delivery?.order?.rating != null)
        //   RatingBarIndicator(
        //     rating: delivery?.order.rating,
        //     itemBuilder: (context, index) => Icon(
        //       Icons.star,
        //       color: Colors.amber,
        //     ),
        //     itemCount: 5,
        //     itemSize: TSize.iconSm,
        //   ),
      ],
    );
  }

  Widget _buildLocationInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.storefront, color: TColor.primary),
            SizedBox(width: TSize.spaceBetweenItemsMd),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: 'Pickup: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: delivery?.pickupLocation,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: TColor.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: TSize.spaceBetweenItemsSm),
        Row(
          children: [
            Icon(Icons.location_on, color: TColor.primary),
            SizedBox(width: TSize.spaceBetweenItemsMd),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: 'Drop-Off: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: delivery?.dropOffLocation,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: TColor.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: TSize.spaceBetweenItemsSm),
        Row(
          children: [
            Icon(
              TIcon.clock,
              color: TColor.primary,
            ),
            SizedBox(width: TSize.spaceBetweenItemsMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (delivery?.estimatedDeliveryTime != null)
                    RichText(
                      text: TextSpan(
                        text: 'Estimated: ',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: _formatDateTime(delivery?.estimatedDeliveryTime),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: TColor.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (delivery?.actualDeliveryTime != null)
                    RichText(
                      text: TextSpan(
                        text: 'Delivered: ',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: _formatDateTime(delivery?.actualDeliveryTime),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: TColor.primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                ],
              ),
            )
          ],
        ),
        SizedBox(height: TSize.spaceBetweenItemsSm),
        StatusChip(status: '${delivery?.status}')
      ],
    )   ;
  }

  Widget _buildStatusAndTimeInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: TDeviceUtil.getScreenWidth() * 0.3,
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildImage(context, TImage.hcBurger1),
                  Positioned(
                    left: TSize.md,
                    child: _buildImage(context, TImage.hcBurger1),
                  ),
                  Positioned(
                    left: TSize.md * 2,
                    child: _buildImage(context, TImage.hcBurger1),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: TSize.spaceBetweenItemsHorizontal),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order ID:'),
              Text(
                delivery?.order?.id?.split('-')[0].toString() ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '£${delivery?.order?.total.toStringAsFixed(2) ?? ''}',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.red),
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical / 2),
              RatingBarIndicator(
                rating: THelperFunction.formatDouble(delivery?.order?.rating),
                itemBuilder: (context, index) => SvgPicture.asset(TIcon.fillStar),
                itemCount: 5,
                itemSize: TSize.iconSm,
              ),
            ],
          ),
        ),
        SizedBox(width: TSize.spaceBetweenItemsHorizontal),
        // StatusChip(status: delivery?.status ?? ''),
      ],
    );
  }
  Widget _buildImage(BuildContext context, String imagePath) {
    return Card(
      elevation: TSize.cardElevation,
      surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
      child: Padding(
        padding: EdgeInsets.all(TSize.xs),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(TSize.borderRadiusSm),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: 80,
            height: 80,
          ),
        ),
      ),
    );
  }
  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }
}

class DeliveryCardSkeleton extends StatelessWidget {
  final bool noMargin;

  const DeliveryCardSkeleton({
    Key? key,
    this.noMargin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: noMargin ? EdgeInsets.zero : EdgeInsets.all(TSize.md),
      surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: TSize.cardElevation,
      child: Padding(
        padding: EdgeInsets.all(TSize.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSkeletonDeliveryInfo(),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            _buildSkeletonLocationInfo(),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            _buildSkeletonStatusAndTimeInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonDeliveryInfo() {
    return Row(
      children: [
        BoxSkeleton(width: 100, height: 20),
        Spacer(),
        BoxSkeleton(width: 60, height: 20),
      ],
    );
  }

  Widget _buildSkeletonLocationInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BoxSkeleton(width: 20, height: 20),
            SizedBox(width: TSize.spaceBetweenItemsHorizontal / 2),
            BoxSkeleton(width: 150, height: 20),
          ],
        ),
        SizedBox(height: TSize.spaceBetweenItemsVertical / 2),
        Row(
          children: [
            BoxSkeleton(width: 20, height: 20),
            SizedBox(width: TSize.spaceBetweenItemsHorizontal / 2),
            BoxSkeleton(width: 150, height: 20),
          ],
        ),
      ],
    );
  }

  Widget _buildSkeletonStatusAndTimeInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BoxSkeleton(width: 80, height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BoxSkeleton(width: 120, height: 20),
            SizedBox(height: TSize.spaceBetweenItemsVertical / 2),
            BoxSkeleton(width: 120, height: 20),
          ],
        ),
      ],
    );
  }
}


