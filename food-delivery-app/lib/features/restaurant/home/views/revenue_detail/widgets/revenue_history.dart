import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/fields/date_picker.dart';
import 'package:food_delivery_app/common/widgets/misc/head_with_action.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/cards/order_history_card.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';


class RevenueHistory extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const RevenueHistory({
    required this.orders,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: TSize.spaceBetweenItemsVertical,),
          HeadWithAction(
            title: "Order History",
            action: Expanded(
              child: CDatePicker(
                labelText: "Choose Date",
                controller: TextEditingController(),
              ),
            ),
          ),

          SizedBox(height: TSize.spaceBetweenItemsVertical,),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return OrderHistoryCard(order: orders[index]);
            },
          ),
        ],
      ),
    );
  }
}