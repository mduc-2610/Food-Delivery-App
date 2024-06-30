import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class CategoryCard extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const CategoryCard({
    required this.label,
    required this.icon,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: TSize.cardElevation,
        surfaceTintColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 30,
              height: 30,
            ),
            SizedBox(height: TSize.spaceBetweenItems - 6),
            Text(label, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    );;
  }
}
