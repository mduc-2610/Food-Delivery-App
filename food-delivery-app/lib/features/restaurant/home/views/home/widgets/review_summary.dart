import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/misc/head_with_action.dart';
import 'package:food_delivery_app/features/user/food/views/review/detail_review.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class ReviewsSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadWithAction(
          title: "Reviews",
          actionText: "See all reviews",
          onActionTap: () {
            // Get.to(() => DetailReviewView());
          }
        ),
        Row(
          children: [
            SvgPicture.asset(
              TIcon.fillStar,
              width: TSize.iconSm,
              height: TSize.iconSm,
            ),
            SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

            Text(
              '4.9',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: TColor.star),
            ),
            SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

            Text(' Total 20 Reviews'),
          ],
        ),
      ],
    );
  }
}