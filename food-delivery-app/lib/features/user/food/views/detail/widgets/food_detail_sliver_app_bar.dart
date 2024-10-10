import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar_scroll_behavior.dart';
import 'package:food_delivery_app/features/restaurant/food/controllers/detail/food_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/controllers/detail/food_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/views/detail/widgets/food_detail_flexible_app_bar.dart';

class FoodDetailSliverAppBar extends StatelessWidget {
  const FoodDetailSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller;
    try {
      controller = FoodDetailController.instance;
    }
    catch(e) {
      controller = RestaurantFoodDetailController.instance;
    }
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      title: AppBarScrollBehavior(
        child: Text("${controller.dish?.name}", style: Theme.of(context).textTheme.headlineMedium,),
        isScrollHidden: false,
      ),
      centerTitle: true,
      flexibleSpace: FoodDetailFlexibleAppBar(),
    );
  }
}