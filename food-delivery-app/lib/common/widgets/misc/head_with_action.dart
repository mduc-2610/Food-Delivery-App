import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class HeadWithAction extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? onActionTap;
  final Widget? head;
  final Widget? action;

  HeadWithAction({
    this.head,
    this.action,
    this.title = "",
    this.actionText = "",
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        head ??
        Expanded(
          child: Text(
            "$title",
            style: Theme.of(context).textTheme.headlineMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

        action ??
        GestureDetector(
          onTap: onActionTap,
          child: Text(
            actionText,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: TColor.primary,
              decoration: TextDecoration.underline,
              decorationColor: TColor.primary,
              decorationThickness: 2
            ),
          ),
        ),
      ],
    );
  }
}
