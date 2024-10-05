import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/order/models/promotion.dart';
import 'package:food_delivery_app/features/user/order/views/common/widgets/status_chip.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class PromotionDetail extends StatefulWidget {
  final RestaurantPromotion? promotion;
  final Function()? onEdit;
  final Function()? onToggleDisable;
  final ViewType viewType;

  const PromotionDetail({
    this.promotion,
    this.onEdit,
    this.onToggleDisable,
    this.viewType = ViewType.restaurant,
    Key? key,
  }) : super(key: key);

  @override
  State<PromotionDetail> createState() => _PromotionDetailState();
}

class _PromotionDetailState extends State<PromotionDetail> {
  bool? isDisabled;

  @override
  Widget build(BuildContext context) {
    if(isDisabled == null) {
      isDisabled = widget.promotion?.isDisabled ?? false;
    }
    return SingleChildScrollView(
      child: SizedBox(
        height: TDeviceUtil.getScreenHeight() * 0.8,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            title: _buildPromoTypeIcon(),
            centerTitle: true,
            leading: SizedBox.shrink(),
            actions: [
              (widget.viewType == ViewType.restaurant)
                ? _buildPopupMenu()
                :SizedBox.shrink(),
            ],
          ),
          body: MainWrapper(
            bottomMargin: TSize.spaceBetweenSections,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      Text(
                        widget.promotion?.name ?? 'PROMOTION',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: TSize.spaceBetweenSections),
                _buildPromotionDetail(context, 'Description', detail: widget.promotion?.description ?? 'No description available'),
                _buildPromotionDetail(context, 'Duration', detail:
                    '${THelperFunction.formatDate(widget.promotion?.startDate, format:'dd MMMM yyyy')} - ${THelperFunction.formatDate(widget.promotion?.endDate, format:'dd MMMM yyyy')}'),
                _buildPromotionDetail(context, 'Promo Code', detail: widget.promotion?.code ?? 'N/A'),
                _buildPromotionDetail(context, 'Discount', widget: _buildDiscountRow(context)),
                _buildPromotionDetail(context, 'Status', widget: StatusChip(
                  status: isDisabled == false ? "ACTIVE" : "CANCELLED",
                  text: isDisabled == false ? "ACTIVE" : "DISABLED",
                ),),
                // You might want to add more details here based on your RestaurantPromotion model
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPromoTypeIcon() {
    final isShipping = widget.promotion?.promoType == "Shipping";
    return SvgPicture.asset(
      isShipping ? TIcon.onTheWayOrder : TIcon.discount,
      width: 50,
      height: 50,
    );
  }

  Widget _buildDiscountRow(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.discount, color: TColor.primary),
        SizedBox(width: TSize.spaceBetweenItemsSm),
        Text(
          widget.promotion?.promoType == 'PERCENTAGE'
              ? '${widget.promotion?.discountPercentage}% off'
              : '£${widget.promotion?.discountAmount} off',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: TColor.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPromotionDetail(BuildContext context, String title,
      {
        String? detail,
        Widget? widget
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: TSize.spaceBetweenItemsSm),
        if(detail != null)...[
          Text(
            detail,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ]
        else if(widget != null)...[
         widget
        ],
        SizedBox(height: TSize.spaceBetweenItemsVertical),
      ],
    );
  }

  String _getDiscountText() {
    if (widget.promotion?.promoType == 'PERCENTAGE') {
      return '${widget.promotion?.discountPercentage}% off';
    } else if (widget.promotion?.promoType == 'FIXED') {
      return '£${widget.promotion?.discountAmount} off';
    } else {
      return 'Discount details not available';
    }
  }

  String _getStatusText() {
    if (isDisabled == true) {
      return 'Disabled';
    } else if (isDisabled == true) {
      return 'Active';
    } else {
      return 'Inactive';
    }
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<String>(
      icon: CircleIconCard(
        icon: Icons.more_horiz,
      ),
      onSelected: (String result) {
        if (result == 'edit') {
          widget.onEdit?.call();
        } else if (result == 'toggle') {
          $print("TOGGLE");
          setState(() {
            isDisabled = !(isDisabled ?? false);
          });
          widget.onToggleDisable?.call();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'toggle',
          child: Text(
            isDisabled == true ? 'Enable' : 'Disable',
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