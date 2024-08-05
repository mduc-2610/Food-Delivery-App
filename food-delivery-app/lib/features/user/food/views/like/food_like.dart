import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/menu_bar.dart';
import 'package:food_delivery_app/common/widgets/list/restaurant_list.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/food_card.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class FoodLikeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Liked",
            noLeading: true,
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                MainWrapper(
                  child: Column(
                    children: [
                      CSearchBar(),
                      SizedBox(height: TSize.spaceBetweenSections,),
                      Text(
                        "Not Found",
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.textDesc),
                      ),
                      SizedBox(height: TSize.spaceBetweenSections,),
                      Text(
                        "Empty",
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.textDesc),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 14 / 16,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          RestaurantList(),

                        ],
                      ),
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
