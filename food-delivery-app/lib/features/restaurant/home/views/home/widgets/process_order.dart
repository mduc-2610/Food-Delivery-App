import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/cards/order_history_card.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class ProcessOrder extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  final String label;
  final double? height;

  ProcessOrder({
    required this.orders,
    required this.label,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: MainWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "20 $label",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderHistoryCard(order: orders[index]);
                },
              ),
            ),
            SizedBox(height: TSize.spaceBetweenSections),
          ],
        ),
      ),
    );
  }
}

void showProcessOrder(BuildContext context, List<Map<String, dynamic>> orders, String label, {double? height}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => ProcessOrder(
      orders: orders,
      label: label,
      height: height ?? TDeviceUtil.getScreenHeight() * 0.7,
    ),
  );
}
