import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/list/restaurant_list_controller.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/common/widgets/skeleton/skeleton_list.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/restaurant_card.dart';
import 'package:food_delivery_app/common/widgets/misc/list_check.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RestaurantList extends StatelessWidget {
  final String? category;
  final String? searchResult;
  final bool searchBar;

  const RestaurantList({
    this.category,
    this.searchBar = true,
    this.searchResult,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _tag = category ?? (searchResult != null ? "search" : "");
    return GetBuilder<RestaurantListController>(
      init: RestaurantListController(
        category: category,
        searchResult: searchResult,
      ),
      tag: _tag,
      builder: (controller) {
        return Obx(() =>
            SingleChildScrollView(
              controller: controller.scrollController,
              child: controller.isLoading.value
                  ? RestaurantListSkeleton()
                  : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    if(searchBar)...[
                      MainWrapper(
                          child: CSearchBar(
                            controller: controller.searchTextController,
                            prefixPressed: controller.onSearch,
                          )
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical,),
                    ],

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

class RestaurantListSkeleton extends StatelessWidget {
  final bool searchBar;
  const RestaurantListSkeleton({
    this.searchBar = true,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(searchBar)...[
          MainWrapper(
              child: BoxSkeleton(height: 50, width: double.infinity)
          ),
          SizedBox(height: TSize.spaceBetweenItemsVertical,),
        ],

        SkeletonList(
          length: 5,
          skeleton: RestaurantCardSkeleton(),
          separate: SeparateSectionBar(),
        ),
      ],
    );
  }
}
