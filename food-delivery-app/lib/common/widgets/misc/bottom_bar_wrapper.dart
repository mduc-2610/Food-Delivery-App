import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class BottomBarWrapper extends StatelessWidget {
  final Widget child;
  const BottomBarWrapper({
    required this.child,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: TSize.spaceBetweenItemsVertical,),
          child,
          SizedBox(height: TSize.spaceBetweenSections,)
        ],
      ),
    );
  }
}
