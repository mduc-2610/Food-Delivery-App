import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class MetricCard extends StatelessWidget {
  final int value;
  final String label;
  const MetricCard({
    required this.value,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(TSize.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "$value",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w600)
            ),
            Text(label, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}