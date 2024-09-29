import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/fields/date_picker.dart';
import 'package:food_delivery_app/common/widgets/misc/head_with_action.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/cards/order_history_card.dart';
import 'package:food_delivery_app/features/deliverer/home/views/home/widgets/delivery_card.dart';
import 'package:food_delivery_app/features/restaurant/home/controllers/revenue_detail/revenue_detail_controller.dart';
import 'package:food_delivery_app/features/restaurant/home/views/home/widgets/review_summary.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';


class RevenueHistory extends StatelessWidget {
  final List<Delivery> deliveries;

  const RevenueHistory({
    required this.deliveries,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = RevenueDetailController.instance;
    return
      MainWrapper(
      child: ListView(
        controller: controller.scrollController,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: TSize.spaceBetweenItemsVertical,),
          HeadWithAction(
            title: "Order History",
            action: Expanded(
              child: CDatePicker(
                labelText: "Choose Date",
                controller: TextEditingController(),
                onDateSelected: controller.setDate,
              ),
            ),
          ),

          SizedBox(height: TSize.spaceBetweenItemsVertical,),
          SingleChildScrollView(
            child: Column(
              children: [
                for(var _delivery in deliveries)...[
                  DeliveryCard(
                    delivery: _delivery,
                    isTracking: false,
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsSm,),

                ]
              ],
            ),
          ),
          SizedBox(height: TSize.spaceBetweenItemsVertical,),

        ],
      ),
    );
  }
}