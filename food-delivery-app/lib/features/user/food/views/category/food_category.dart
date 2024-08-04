import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/restaurant_card.dart';
import 'package:food_delivery_app/common/widgets/misc/list_check_empty.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/user/food/controllers/category/food_category_controller.dart';
import 'package:food_delivery_app/common/widgets/cards/food_card_gr.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class FoodCategoryView extends StatelessWidget {
  final FoodCategoryController _controller = Get.put(FoodCategoryController());

  @override
  Widget build(BuildContext context) {
    String category = _controller.category.value;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: category,
            noLeading: (category == "Liked") ? true : false,
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                MainWrapper(
                  child: Column(
                    children: [
                      ListCheckEmpty(
                        child: Column(
                          children: [
                            for(int i = 0; i < 5; i++)...[
                              RestaurantCard(imageUrl: TImage.hcFood1, title: "Burger Restaurant", subtitle: "ok", price: "1.5", rating: "5", reviewCount: "5", tag: "2"),
                              SeparateSectionBar()
                            ]
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
