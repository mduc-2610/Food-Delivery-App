import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/features/food/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/food/views/common/widgets/category_card.dart';
import 'package:food_delivery_app/features/food/views/common/widgets/food_card.dart';
import 'package:food_delivery_app/features/food/views/home/widgets/home_sliver_app_bar.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class HomeView extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HomeSliverAppBar(),

          SliverToBoxAdapter(
            child: Column(
              children: [
                MainWrapper(
                  rightMargin: 0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: TDeviceUtil.getScreenHeight() * 0.15,
                      child: Row(
                        children: [
                          Image.asset(
                            TImage.eventBanner1,
                          ),
                          Image.asset(
                            TImage.eventBanner2,
                          )
                      ],
                                        ),
                    )),
                ),
                SizedBox(height: TSize.spaceBetweenSections,),

                MainWrapper(
                  child: Column(
                    children: [
                      CSearchBar(),

                      GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          CategoryCard(label: 'Burger', icon: TIcon.burger, onTap: () {_controller.getToFoodCategory("Burger");}),
                          CategoryCard(label: 'Taco', icon: TIcon.taco, onTap: () {_controller.getToFoodCategory("Taco");}),
                          CategoryCard(label: 'Burrito', icon: TIcon.burrito, onTap: () {_controller.getToFoodCategory("Burrito");}),
                          CategoryCard(label: 'Drink', icon: TIcon.drink, onTap: () {_controller.getToFoodCategory("Drink");}),
                          CategoryCard(label: 'Pizza', icon: TIcon.pizza, onTap: () {_controller.getToFoodCategory("Pizza");}),
                          CategoryCard(label: 'Donut', icon: TIcon.donut, onTap: () {_controller.getToFoodCategory("Donut");}),
                          CategoryCard(label: 'Salad', icon: TIcon.salad, onTap: () {_controller.getToFoodCategory("Salad");}),
                          CategoryCard(label: 'Noodles', icon: TIcon.noodles, onTap: () {_controller.getToFoodCategory("Noodles");}),
                          CategoryCard(label: 'Sandwich', icon: TIcon.sandwich, onTap: () {_controller.getToFoodCategory("Sandwich");}),
                          CategoryCard(label: 'Pasta', icon: TIcon.pasta, onTap: () {_controller.getToFoodCategory("Pasta");}),
                          CategoryCard(label: 'Ice Cream', icon: TIcon.iceCream, onTap: () {_controller.getToFoodCategory("Ice Cream");}),
                          CategoryCard(label: 'More', icon: TIcon.moreHoriz, onTap: _controller.getToFoodMore),
                        ],
                      ),
                      SizedBox(height: TSize.spaceBetweenSections,),

                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Special Offers', style: Theme.of(context).textTheme.headlineMedium),
                              GestureDetector(
                                onTap: () {},
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('View All ', style:
                                    Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        color: TColor.primary,
                                        // fontWeight: FontWeight.w600
                                    )),
                                    Icon(
                                      TIcon.arrowFoward,
                                      size: TSize.iconSm,
                                      color: TColor.primary,
                                    )
                                  ],
                                ),
                              ),
                            ],
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
                                onTap: () {_controller.getToFoodDetail("");},
                                image: TImage.hcFood1,
                                name: "Chicken Burger",
                                stars: 4.9,
                                originalPrice: 10.00,
                                salePrice: 6.00,
                              ),
                              FoodCard(
                                onTap: () {_controller.getToFoodDetail("");},
                                image: TImage.hcFood1,
                                name: "Chicken Burger",
                                stars: 4.9,
                                originalPrice: 10.00,
                                salePrice: 6.00,
                              ),
                              FoodCard(
                                onTap: () {_controller.getToFoodDetail("");},
                                image: TImage.hcFood1,
                                name: "Chicken Burger",
                                stars: 4.9,
                                originalPrice: 10.00,
                                salePrice: 6.00,
                              ),
                              FoodCard(
                                onTap: () {_controller.getToFoodDetail("");},
                                image: TImage.hcFood1,
                                name: "Chicken Burger",
                                stars: 4.9,
                                originalPrice: 10.00,
                                salePrice: 6.00,
                              ),

                            ],
                          ),
                          SizedBox(height: TSize.spaceBetweenSections,),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
