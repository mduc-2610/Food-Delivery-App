import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar_scroll_behavior.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/features/user/food/restaurant/widgets/restaurant_detail_flexible_app_bar.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class RestaurantDetailSliverAppBar extends StatelessWidget {
  final PreferredSizeWidget? bottom;

  const RestaurantDetailSliverAppBar({
    this.bottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 230,
      floating: false,
      pinned: true,
      title: AppBarScrollBehavior(
        child: Row(
          children: [
            Expanded(
              child: CSearchBar(),
            ),
            SizedBox(width: TSize.spaceBetweenItemsSm,),
            CircleIconCard(
              iconStr: TIcon.cart,
            ),
            CircleIconCard(
              icon: Icons.more_horiz,
              iconColor: TColor.primary,
            ),
          ],
        ),
        isScrollHidden: false,
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: RestaurantDetailFlexibleAppBar(),
      ),
      bottom: bottom,
    );
  }
}
