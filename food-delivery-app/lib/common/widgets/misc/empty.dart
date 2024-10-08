import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class EmptyWidget extends StatelessWidget {
  final String message;

  const EmptyWidget({
    super.key,
    this.message = "No items available\n at the moment.",
  });


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: TSize.iconNotify, color: Colors.grey.shade400),
          SizedBox(height: TSize.spaceBetweenItemsVertical),
          Text(
            message,
            style: Get.textTheme.titleMedium?.copyWith(fontSize: 18, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
