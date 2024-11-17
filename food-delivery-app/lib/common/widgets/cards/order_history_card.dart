import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/user/order/controllers/history/order_history_controller.dart';
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
  final VoidCallback? onTap;

  const OrderHistoryCard({
    Key? key,
    this.restaurantCart,
    this.order,
    this.noMargin = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Order? currentOrder = order ?? restaurantCart?.order;
    var controller;
    try {
      controller = OrderHistoryController.instance;
    }
    catch(e) {

    }
    final List<RestaurantCartDish> dishes = order?.cart?.cartDishes ?? [];
    return GestureDetector(
      onTap: onTap ?? () async {
        // $print("INITIALIZE");
        final result = (await Get.to(() => OrderHistoryDetailView(), arguments: {
          'id': order?.id
          })) as Map<String, Order?>;
        final _order = result["order"];
        if(_order?.status != order?.status) {
          if(controller != null)
            await controller.initialize();
        }

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
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: TDeviceUtil.getScreenWidth() * 0.3,
                      child: Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              if(dishes.length > 0)...[
                                _buildImage(context, dishes[0].dish.image)
                              ],
                              if(dishes.length > 1)...[
                                Positioned(
                                  left: TSize.md,
                                  child: _buildImage(context, dishes[1].dish.image)
                                ),
                              ],
                              if(dishes.length > 2)...[
                                Positioned(
                                  left: TSize.md * 2,
                                  child: _buildImage(context, dishes[2].dish.image)
                                ),
                              ]
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
                //
                if(currentOrder?.status == "COMPLETED" && currentOrder?.isReviewed == false)...[
                  Positioned(
                    top: -5,
                    right: -5,
                    child: SvgPicture.asset(
                      TIcon.notifyDot,
                    ),
                  )
                ]
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
          child: THelperFunction.getValidImage(
              imagePath,
              width: 80,
              height: 80
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