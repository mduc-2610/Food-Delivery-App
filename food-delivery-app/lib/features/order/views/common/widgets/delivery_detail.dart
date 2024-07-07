import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';


class DeliveryDetail extends StatelessWidget {
  final String address;
  final String paymentMethod;
  final double subtotal;
  final double discount;
  final double total;
  final String fromView;

  DeliveryDetail({
    required this.address,
    required this.paymentMethod,
    required this.subtotal,
    required this.discount,
    required this.total,
    this.fromView = "Cancel",
  });

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _buildCard(context, () {}, TIcon.location, "Deliver to", "Description"),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              _buildCard(context, () {}, TIcon.payment, "Payment method", "Cash"),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              _buildCard(context, () {}, TIcon.promotion, "Promotions", "Free shipping 20%"),
            ],
          ),
          SizedBox(height: TSize.spaceBetweenSections),

          Column(
            children: [
              _buildRow(context, "Subtotal", "£ ${subtotal.toStringAsFixed(2)}"),
              _buildRow(context, "Delivery Fee", "FREE"),
              _buildRow(context, "Discount", "- £ ${discount.toStringAsFixed(2)}"),
              Divider(),
              _buildRow(context, "Total", "£ ${total.toStringAsFixed(2)}"),
            ],
          ),
          SizedBox(height: TSize.spaceBetweenSections),
          _buildReviewOrCancellationSection(context),
          SizedBox(height: TSize.spaceBetweenSections),
          _buildActionButtons(context),

        ],
      ),
    );
  }

  InkWell _buildCard(BuildContext context, VoidCallback onTap, IconData icon, String title, String description) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: TSize.sm,
            horizontal: TSize.md
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: TColor.textDesc,
          ),
          borderRadius: BorderRadius.circular(TSize.borderRadiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  TIcon.location,
                  color: TColor.primary,
                ),
                SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                Text(
                    'Deliver to'
                )
              ],
            ),
            Text(
              '221B Baker Street, London, United Kingdom',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String title, String value, [Color? valueColor]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.primary),
        ),
      ],
    );
  }

  Widget _buildReviewOrCancellationSection(BuildContext context) {
    bool isReviewing = false;
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

  Widget _buildActionButtons(BuildContext context) {
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
        padding: EdgeInsets.symmetric(
          vertical: TSize.sm + 5,
          horizontal: TSize.sm,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (fromView == "Basket") ? null :  () {},
              child: Text(
                (fromView == "Basket") ? "£ $total" : "Cancel Order",
                style:
                (fromView == "Basket")
                    ? Theme.of(context).textTheme.headlineSmall
                    : Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.textDesc),
              ),
            ),
            SizedBox(width: TSize.spaceBetweenSections * ((fromView == "Basket") ? 2 : 1)),
            SizedBox(
              width: TDeviceUtil.getScreenWidth() * 0.45,
              child: MainButton(
                paddingHorizontal: TSize.lg,
                onPressed: () {},
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