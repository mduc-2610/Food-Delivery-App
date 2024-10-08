import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: TSize.iconNotify, color: Colors.grey),
          SizedBox(height: TSize.spaceBetweenItemsVertical),
          Text(
            message,
            style: Get.textTheme.titleMedium?.copyWith(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}