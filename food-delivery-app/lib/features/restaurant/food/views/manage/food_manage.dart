import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/restaurant/food/controllers/manage/food_manage_controller.dart';
import 'package:food_delivery_app/features/restaurant/food/views/manage/skeleton/food_manage_skeleton.dart';
import 'package:food_delivery_app/features/restaurant/food/views/manage/widgets/promotion_manage_card.dart';
import 'package:food_delivery_app/features/restaurant/food/views/manage/widgets/restaurant_food_card.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/category_selection.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/order/models/promotion.dart';
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
          return (controller.isLoading.value)
              ? FoodManageSkeleton()
              : DefaultTabController(
            length: controller.categories.length + 2,
            child: Scaffold(
              appBar: CAppBar(
                title: 'My Food',
                noLeading: true,
                bottom: TabBar(
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  tabs: [
                    Tab(text: "Promotions"),
                    Tab(text: 'All'),
                    ...controller.categories.map((category) => Tab(text: category.name)),
                  ],
                ),
                iconList: [
                  {
                    "icon": Icons.add,
                    "onPressed": () async {
                      final checkOnSave = await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return MainWrapper(
                            child: CategorySelection(onSave: () {},)
                          );
                        }
                      );
                      if(checkOnSave != null && checkOnSave == true) {
                        await controller.initialize();
                      }
                    }
                  }
                ],
              ),
              body: TabBarView(
                children: [
                  Obx(() => _buildPromotionList(controller.promotions, controller)),
                  Obx(() => _buildFoodList(controller.dishes, controller)),
                  ...controller.categories.map((category) =>
                      Obx(() => _buildFoodList(controller.mapCategory[category.name] ?? [], controller))),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildFoodList(List<Dish> dishes, FoodManageController controller) {
    return ListView.separated(
        padding: EdgeInsets.all(TSize.spaceBetweenItemsSm),
        itemCount: dishes.length,
        separatorBuilder: (context, index) => SizedBox(height: TSize.spaceBetweenItemsSm),
        itemBuilder: (context, index) => RestaurantFoodCard(
        dish: dishes[index],
        onToggleDisable: () => controller.handleDishDisable(dishes[index]),
        onEdit: () => controller.handleDishEditInformation(dishes[index]),
      )
    );
  }

  Widget _buildPromotionList(List<RestaurantPromotion> promotions, FoodManageController controller) {
    return ListView.separated(
        controller: controller.scrollController,
        padding: EdgeInsets.all(TSize.spaceBetweenItemsSm),
        itemCount: promotions.length,
        separatorBuilder: (context, index) => SizedBox(height: TSize.spaceBetweenItemsSm),
        itemBuilder: (context, index) => PromotionManageCard(
        promotion: promotions[index],
        onToggleDisable: () => controller.handlePromotionDisable(promotions[index]),
        onEdit: () => controller.handlePromotionEditInformation(promotions[index]),
      )
    );
  }
}
