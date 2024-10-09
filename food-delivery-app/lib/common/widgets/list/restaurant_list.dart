import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/list/restaurant_list_controller.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/empty.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/misc/not_found.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/common/widgets/skeleton/skeleton_list.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
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
  final bool isLike;
  final String? tag;

  const RestaurantList({
    this.category,
    this.searchBar = true,
    this.searchResult,
    this.isLike = false,
    this.tag,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _tag = tag ?? category ?? (searchResult != null ? "search" : "");
    $print("TAG: $_tag");
    return GetBuilder<RestaurantListController>(
      init: RestaurantListController(
        category: category,
        searchResult: searchResult,
        isLike: isLike,
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

                    Column(
                      children: [
                        if(controller.restaurants.isEmpty)...[
                          if(controller.searchTextController.text == "")...[
                            SizedBox(height: TDeviceUtil.getScreenHeight() * 0.3),
                            Center(child: EmptyWidget()),
                          ]
                          else...[
                            SizedBox(height: TDeviceUtil.getScreenHeight() * 0.3),
                            Center(child: NotFoundWidget()),
                          ]
                        ]
                        else...[
                          for(var restaurant in controller.restaurants)...[
                              RestaurantCard(
                                restaurant: restaurant,
                                dishPageSize: controller.dishPageSize,
                                category: category,
                              ),
                              SeparateSectionBar(),
                          ],
                          SizedBox(height: TSize.spaceBetweenSections,)
                        ]
                      ],
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
