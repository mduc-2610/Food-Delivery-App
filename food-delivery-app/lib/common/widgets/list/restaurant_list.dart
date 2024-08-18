import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/list/restaurant_list_controller.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantListController>(
      init: RestaurantListController(),
      builder: (controller) {
        return Obx(() =>
            SingleChildScrollView(
              controller: controller.scrollController,
              child: controller.isLoading.value
                  ? SkeletonList(
                length: 5,
                skeleton: RestaurantCardSkeleton(),
                separate: SeparateSectionBar(),
              )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        CSearchBar(controller: controller.searchTextController, prefixPressed: controller.onSearch,),
                        ListCheck(
                          checkNotFound: controller.restaurants.length == 0,
                          child: Column(
                            children: [
                              for(var restaurant in controller.restaurants)...[
                                RestaurantCard(restaurant: restaurant),
                                SeparateSectionBar(),
                              ],
                              SizedBox(height: TSize.spaceBetweenSections,)
                            ],
                          ),
                        ),
                      ]
                  ),
            )
        );
      },
    );
  }

}
