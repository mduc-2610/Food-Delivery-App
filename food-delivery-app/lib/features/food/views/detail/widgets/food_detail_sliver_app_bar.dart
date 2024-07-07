import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar_scroll_behavior.dart';
import 'package:food_delivery_app/features/food/views/detail/widgets/food_detail_flexible_app_bar.dart';

class FoodDetailSliverAppBar extends StatelessWidget {
  const FoodDetailSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      title: AppBarScrollBehavior(
        child: Text("Burder Detail", style: Theme.of(context).textTheme.headlineMedium,),
        isScrollHidden: false,
      ),
      centerTitle: true,
      flexibleSpace: FoodDetailFlexibleAppBar(),
    );
  }
}