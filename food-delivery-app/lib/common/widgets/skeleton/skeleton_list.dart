import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class SkeletonList extends StatelessWidget {
  final int length;
  final Widget skeleton;
  final Widget? separate;
  final double space;

  const SkeletonList({
    required this.skeleton,
    this.length = 5,
    this.separate,
    this.space = TSize.spaceBetweenItemsVertical,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(length, (index) {
          return Column(
            children: [
              skeleton,
              separate ?? SizedBox(
                height: space,
              )
            ],
          );
        })
      ),
    );
  }
}
