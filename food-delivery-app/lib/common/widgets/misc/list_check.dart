import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class ListCheck extends StatelessWidget {
  final Widget child;
  final bool checkEmpty;
  final bool checkNotFound;

  const ListCheck({
    required this.child,
    this.checkEmpty = false,
    this.checkNotFound = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(checkEmpty)...[
          SizedBox(height: TSize.spaceBetweenSections,),
          Text(
            "Empty",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.textDesc),
          ),
        ]

        else if(checkNotFound)...[
          SizedBox(height: TSize.spaceBetweenSections,),
          Text(
            "Not Found",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.textDesc),
          ),
        ]
        else...[
          child
        ]
      ],
    );
  }
}
