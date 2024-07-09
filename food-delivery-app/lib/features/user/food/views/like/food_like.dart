import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/menu_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/user/food/controllers/category/food_category_controller.dart';
import 'package:food_delivery_app/features/user/food/views/common/widgets/food_card.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class FoodLikeView extends StatelessWidget {
  final FoodCategoryController _controller = Get.put(FoodCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
              title: "Liked",
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
                          FoodCard(
                            onTap: _controller.getToFoodDetail,
                            image: TImage.hcFood1,
                            name: "Chicken Burger",
                            stars: 4.9,
                            originalPrice: 10.00,
                            salePrice: 6.00,
                            heart: TIcon.fillHeart,
                          ),
                          FoodCard(
                            onTap: _controller.getToFoodDetail,
                            image: TImage.hcFood1,
                            name: "Chicken Burger",
                            stars: 4.9,
                            originalPrice: 10.00,
                            salePrice: 6.00,
                            heart: TIcon.fillHeart,
                          ),
                          FoodCard(
                            onTap: _controller.getToFoodDetail,
                            image: TImage.hcFood1,
                            name: "Chicken Burger",
                            stars: 4.9,
                            originalPrice: 10.00,
                            salePrice: 6.00,
                            heart: TIcon.fillHeart,
                          ),
                          FoodCard(
                            onTap: _controller.getToFoodDetail,
                            image: TImage.hcFood1,
                            name: "Chicken Burger",
                            stars: 4.9,
                            originalPrice: 10.00,
                            salePrice: 6.00,
                            heart: TIcon.fillHeart,
                          ),

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
      bottomNavigationBar: CMenuBar(index: 2,),
    );
  }
}
