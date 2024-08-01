import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class ListCheckEmpty extends StatelessWidget {
  final Widget child;

  const ListCheckEmpty({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: TSize.spaceBetweenSections,),
        Text(
          "Not Found",
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.textDesc),
        ),
        SizedBox(height: TSize.spaceBetweenSections,),
        Text(
          "Empty",
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.textDesc),
        ),
        child
      ],
    );
  }
}
