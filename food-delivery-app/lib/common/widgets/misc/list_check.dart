import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/empty.dart';
import 'package:food_delivery_app/common/widgets/misc/not_found.dart';
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
          EmptyWidget(),
        ]

        else if(checkNotFound)...[
          SizedBox(height: TSize.spaceBetweenSections,),
          NotFoundWidget()
        ]
        else...[
          child
        ]
      ],
    );
  }
}
