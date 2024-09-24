import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/features/restaurant/food/controllers/manage/food_manage_controller.dart';
import 'package:food_delivery_app/features/restaurant/food/views/manage/skeleton/food_manage_skeleton.dart';
import 'package:food_delivery_app/features/restaurant/food/views/manage/widgets/restaurant_food_card.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class FoodManageView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodManageController>(
      init: FoodManageController(),
      builder: (controller) {
        return Obx(() {
          return
            (controller.isLoading.value)
            ? FoodManageSkeleton()
            : DefaultTabController(
            length: controller.categories.length + 1,
            child: Scaffold(
              appBar: CAppBar(
                title: 'My Food',
                noLeading: true,
                bottom: TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'All'),
                    ...controller.categories.map((category) => Tab(text: category.name)),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  _buildFoodList(controller.dishes),
                  ...controller.categories.map((category) =>
                      _buildFoodList(controller.mapCategory[category.name] ?? [])
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildFoodList(List<Dish> dishes) {
    return ListView.separated(
      padding: EdgeInsets.all(TSize.spaceBetweenItemsSm),
      itemCount: dishes.length,
      separatorBuilder: (context, index) => SizedBox(height: 0),
      itemBuilder: (context, index) => RestaurantFoodCard(dish: dishes[index]),
    );
  }
}