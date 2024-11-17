import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/list/food_list_controller.dart';
import 'package:food_delivery_app/common/widgets/cards/food_card.dart';
import 'package:food_delivery_app/common/widgets/cards/suggested_food_card.dart';
import 'package:food_delivery_app/common/widgets/misc/list_check.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';

enum Direction { vertical, horizontal }

class FoodList extends StatelessWidget {
  final List<Dish> dishes;
  final List<Dish> extraDishes;
  final Direction direction;
  final double? horizontalItemWidth;
  final bool noMargin;
  final bool suggested;

  const FoodList({
    Key? key,
    required this.dishes,
    this.extraDishes = const [],
    this.direction = Direction.vertical,
    this.horizontalItemWidth,
    this.noMargin = false,
    this.suggested = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FoodListController());

    return direction == Direction.vertical
        ? _buildVerticalList()
        : _buildHorizontalList();
  }


  Widget getFoodCard({
    required FoodCardType type,
    required Dish dish,
    Color? cardColor,
  }) {
    if (suggested) {
      return SuggestedFoodCard(
        type: type,
        dish: dish,
        cardColor: cardColor,
        resTag: true,
      );
    }
    return FoodCard(
      type: type,
      dish: dish,
      cardColor: cardColor,
    );
  }

  Widget _buildVerticalList() {
    return SingleChildScrollView(
      child: MainWrapper(
        noMargin: noMargin,
        child: ListCheck(
          checkEmpty: dishes.isEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var dish in dishes)
                getFoodCard(
                  type: FoodCardType.list,
                  dish: dish,
                ),
              SizedBox(height: TSize.spaceBetweenSections,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ListCheck(
        checkEmpty: dishes.isEmpty,
        child: Row(
          children: [
            for (var dish in extraDishes) ...[
              Container(
                margin: EdgeInsets.only(left: TSize.spaceBetweenItemsHorizontal),
                width: horizontalItemWidth ?? TDeviceUtil.getScreenWidth() * 0.9,
                child: getFoodCard(
                  type: FoodCardType.list,
                  dish: dish,
                  cardColor: Colors.red.withOpacity(0.3),
                ),
              ),
            ],
            for (var dish in dishes) ...[
              Container(
                margin: EdgeInsets.only(left: TSize.spaceBetweenItemsHorizontal),
                width: horizontalItemWidth ?? TDeviceUtil.getScreenWidth() * 0.9,
                child: getFoodCard(
                  type: FoodCardType.list,
                  dish: dish,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}