import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/list/restaurant_list.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_category_controller.dart';
import 'package:get/get.dart';

class RestaurantSearchView extends StatelessWidget {
  final String? searchResult;
  // final RestaurantCategoryController _controller = Get.put(RestaurantCategoryController());
  const RestaurantSearchView({
    this.searchResult
  });

  @override
  Widget build(BuildContext context) {
    // String category = _controller.category.value;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Search result for ${searchResult?.substring(0, max(searchResult?.length ?? 0 , 0)) ?? ''}...",
            // noLeading: (category == "Liked") ? true : false,
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                RestaurantList(searchResult: searchResult,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
