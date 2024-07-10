import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar_scroll_behavior.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class ProfileFlexibleSpaceBar extends StatelessWidget {
  const ProfileFlexibleSpaceBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBarScrollBehavior(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: TColor.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Positioned(
            left: TSize.getPosCenterHorizontal(),
            top: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Available Balance',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.light),
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),
                Text(
                  '\$500.00',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: TColor.light),
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),
                SmallButton(
                  borderColor: TColor.light,
                  text: 'Withdraw',
                  onPressed: () {},
                  borderWidth: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}