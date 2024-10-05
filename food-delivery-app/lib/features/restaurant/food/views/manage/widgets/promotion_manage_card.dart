import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/user/order/models/promotion.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/features/user/order/views/promotion/order_promotion_detail.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class PromotionManageCard extends StatelessWidget {
  final RestaurantPromotion? promotion;
  final Function()? onEdit;
  final Function()? onToggleDisable;

  const PromotionManageCard({
    Key? key,
    this.promotion,
    this.onEdit,
    this.onToggleDisable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return PromotionDetail(
                promotion: promotion,
                onEdit: onEdit,
                onToggleDisable: onToggleDisable,
              );
            }
        );
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(TSize.spaceBetweenItemsMd),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TSize.borderRadiusLg),
            color: promotion?.isDisabled == true ? Colors.grey[300] : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPromoTypeIcon(),
              SizedBox(width: TSize.spaceBetweenItemsMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      promotion?.name ?? '',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: TSize.spaceBetweenItemsSm),
                    Text(
                      promotion?.description ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: TSize.spaceBetweenItemsMd),
                    _buildDiscountRow(context),
                    SizedBox(height: TSize.spaceBetweenItemsSm),
                    _buildDateRow(context, "Start", promotion?.startDate),
                    _buildDateRow(context, "End", promotion?.endDate),
                  ],
                ),
              ),
              SizedBox(width: TSize.spaceBetweenItemsSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildPopupMenu(),
                  SizedBox(height: TSize.spaceBetweenItemsMd),
                  StatusChip(
                    status: promotion?.isDisabled == false ? "ACTIVE" : "CANCELLED",
                    text: promotion?.isDisabled == false ? "ACTIVE" : "DISABLED",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoTypeIcon() {
    final isShipping = promotion?.promoType == "Shipping";
    return CircleIconCard(
      iconStr: isShipping ? TIcon.onTheWayOrder : TIcon.discount,
      backgroundColor: isShipping ? TColor.iconBgSuccess : TColor.iconBgInfo,
      padding: TSize.md,
    );
  }

  Widget _buildDiscountRow(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.discount, color: TColor.primary),
        SizedBox(width: TSize.spaceBetweenItemsSm),
        Text(
          promotion?.promoType == 'PERCENTAGE'
              ? '${promotion?.discountPercentage}% off'
              : '£${promotion?.discountAmount} off',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: TColor.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDateRow(BuildContext context, String label, DateTime? date) {
    return Row(
      children: [
        Icon(Icons.calendar_today, size: TSize.iconSm),
        SizedBox(width: TSize.spaceBetweenItemsSm),
        Text(
          "$label: ",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          "${THelperFunction.formatDate(date, format: "dd MMMM yyyy")}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<String>(
      icon: CircleIconCard(
        icon: Icons.more_horiz,
      ),
      onSelected: (String result) {
        if (result == 'edit') {
          onEdit?.call();
        } else if (result == 'toggle') {
          onToggleDisable?.call();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'toggle',
          child: Text(
            promotion?.isDisabled == true ? 'Enable' : 'Disable',
            style: Get.textTheme.bodyMedium,
          ),
        ),
        PopupMenuItem<String>(
          value: 'edit',
          child: Text(
            'Edit Information',
            style: Get.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}