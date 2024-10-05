import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/features/restaurant/food/views/add/widgets/food_add.dart';
import 'package:food_delivery_app/features/restaurant/food/views/add/widgets/promotion_add.dart';

class RestaurantAddView extends StatelessWidget {
  final String? promotionId;
  final String? dishId;

  const RestaurantAddView({
    this.promotionId,
    this.dishId,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: promotionId != null ? 1 : 0,
      child: Scaffold(
        appBar: CAppBar(
          title: "Manage Items",
          bottom: TabBar(
            tabs: [
              Tab(text: "Food"),
              Tab(text: "Promotions"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FoodAddView(dishId: dishId,),
            PromotionAddView(promotionId: promotionId,),
          ],
        ),
      ),
    );
  }
}