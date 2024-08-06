import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/list/restaurant_list_controller.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/common/widgets/skeleton/restaurant_card_skeleton.dart';
import 'package:food_delivery_app/common/widgets/skeleton/skeleton_list.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/restaurant_card.dart';
import 'package:food_delivery_app/common/widgets/misc/list_check.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  final _restaurantController = Get.put(RestaurantListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      ListCheck(
      child: _restaurantController.isLoading.value
      ? SkeletonList(
        length: 5,
        skeleton: RestaurantCardSkeleton(),
        separate: SeparateSectionBar(),
      )
      : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            for(var restaurant in _restaurantController.restaurants)...[
              RestaurantCard(restaurant: restaurant),
              SeparateSectionBar(),
            ]
          ]
      ),
    ));
  }

}
