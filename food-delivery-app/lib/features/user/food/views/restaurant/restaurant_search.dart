import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/list/restaurant_list.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_category_controller.dart';
import 'package:get/get.dart';

class RestaurantSearchView extends StatelessWidget {
  final RestaurantCategoryController _controller = Get.put(RestaurantCategoryController());

  @override
  Widget build(BuildContext context) {
    String category = _controller.category.value;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: CSearchBar(),
            noLeading: (category == "Liked") ? true : false,
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                RestaurantList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
