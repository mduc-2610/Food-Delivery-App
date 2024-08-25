import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/list/food_list_controller.dart';
import 'package:food_delivery_app/common/widgets/cards/food_card.dart';
import 'package:food_delivery_app/common/widgets/misc/list_check.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';

enum Direction { vertical, horizontal }

class FoodList extends StatelessWidget {
  final List<Dish> dishes;
  final Direction direction;
  final double? horizontalItemWidth;

  const FoodList({
    Key? key,
    required this.dishes,
    this.direction = Direction.vertical,
    this.horizontalItemWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FoodListController());

    return direction == Direction.vertical
        ? _buildVerticalList()
        : _buildHorizontalList();
  }

  Widget _buildVerticalList() {
    return SingleChildScrollView(
      child: MainWrapper(
        child: ListCheck(
          checkEmpty: dishes.isEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var dish in dishes)
                FoodCard(
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
            for (var dish in dishes) ...[
              Container(
                margin: EdgeInsets.only(left: TSize.spaceBetweenItemsHorizontal),
                width: horizontalItemWidth ?? TDeviceUtil.getScreenWidth() * 0.9,
                child: FoodCard(
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