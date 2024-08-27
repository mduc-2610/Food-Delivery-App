import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/features/user/order/views/history/order_history_detail.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderHistoryCard extends StatelessWidget {
  final RestaurantCart? restaurantCart;
  final Order? order;
  final bool noMargin;

  const OrderHistoryCard({
    Key? key,
    this.restaurantCart,
    this.order,
    this.noMargin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine which data source to use
    final Order? currentOrder = order ?? restaurantCart?.order;

    return GestureDetector(
      onTap: () {
        Get.to(() => OrderHistoryDetailView());
      },
      child: MainWrapper(
        noMargin: noMargin,
        child: Card(
          surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: TSize.cardElevation,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: TSize.md,
              vertical: TSize.sm,
            ),
            child: Row(
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
                        currentOrder?.id?.split('-')[0].toString() ?? '',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '£${currentOrder?.total.toStringAsFixed(2) ?? ''}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.red),
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical / 2),
                      RatingBarIndicator(
                        rating: THelperFunction.formatDouble(currentOrder?.rating),
                        itemBuilder: (context, index) => SvgPicture.asset(TIcon.fillStar),
                        itemCount: 5,
                        itemSize: TSize.iconSm,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                StatusChip(status: currentOrder?.status ?? ''),
              ],
            ),
          ),
        ),
      ),
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
}


class OrderHistoryCardSkeleton extends StatelessWidget {
  final bool noMargin;
  const OrderHistoryCardSkeleton({
    this.noMargin = false,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      noMargin: noMargin,
      child: Card(
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: TSize.cardElevation,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: TSize.md,
            vertical: TSize.sm,
          ),
          child: Row(
            children: [
              SizedBox(
                width: TDeviceUtil.getScreenWidth() * 0.3,
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _buildSkeletonImage(),
                        Positioned(
                          left: TSize.md,
                          child: _buildSkeletonImage(),
                        ),
                        Positioned(
                          left: TSize.md * 2,
                          child: _buildSkeletonImage(),
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
                    _buildSkeletonText(),

                    SizedBox(height: TSize.spaceBetweenItemsVertical / 2),
                    _buildSkeletonRatingBar(),
                  ],
                ),
              ),
              SizedBox(width: TSize.spaceBetweenItemsHorizontal),
              _buildSkeletonStatusChip(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonImage() {
    return BoxSkeleton(
      height: 80,
      width: 80,
      borderRadius: TSize.borderRadiusSm,
    );
  }

  Widget _buildSkeletonText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoxSkeleton(
          height: 16,
          width: 100,
          borderRadius: TSize.borderRadiusSm,
        ),
        SizedBox(height: TSize.spaceBetweenItemsVertical / 4),
        BoxSkeleton(
          height: 20,
          width: 80,
          borderRadius: TSize.borderRadiusSm,
        ),
      ],
    );
  }

  Widget _buildSkeletonRatingBar() {
    return BoxSkeleton(
      height: 20,
      width: 100,
      borderRadius: TSize.borderRadiusSm,
    );
  }

  Widget _buildSkeletonStatusChip() {
    return BoxSkeleton(
      height: 23,
      width: 80,
      borderRadius: TSize.borderRadiusLg,
    );
  }
}