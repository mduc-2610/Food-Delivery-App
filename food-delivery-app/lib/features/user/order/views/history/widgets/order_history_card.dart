import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/features/user/order/views/history/order_history_detail.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';

class OrderHistoryCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderHistoryCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderHistoryDetailView());
      },
      child: Card(
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: TSize.cardElevation,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: TSize.md,
            vertical: TSize.sm
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
                        _buildImage(context, order['image']),
                        Positioned(
                          left: TSize.md,
                          child: _buildImage(context, order['image']),
                        ),
                        Positioned(
                          left: TSize.md * 2,
                          child: _buildImage(context, order['image']),
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
                      '${order['id']}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '£${order['price'].toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.red),
                    ),
                    SizedBox(height: TSize.spaceBetweenItemsVertical / 2),
                    RatingBarIndicator(
                      rating: order['rating'].toDouble(),
                      itemBuilder: (context, index) => SvgPicture.asset(TIcon.fillStar),
                      itemCount: 5,
                      itemSize: TSize.iconSm,
                    ),
                  ],
                ),
              ),
              SizedBox(width: TSize.spaceBetweenItemsHorizontal),

              StatusChip(status: order['status']),
            ],
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