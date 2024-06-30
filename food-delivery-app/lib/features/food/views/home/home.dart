import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/features/food/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/food/views/home/widgets/category_card.dart';
import 'package:food_delivery_app/features/food/views/home/widgets/food_card.dart';
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
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(TIcon.search)
                        ),
                      ),

                      GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          CategoryCard(label: 'Burger', icon: TIcon.burger, onTap: (){}),
                          CategoryCard(label: 'Taco', icon: TIcon.taco, onTap: (){}),
                          CategoryCard(label: 'Burrito', icon: TIcon.burrito, onTap: (){}),
                          CategoryCard(label: 'Drink', icon: TIcon.drink, onTap: (){}),
                          CategoryCard(label: 'Pizza', icon: TIcon.pizza, onTap: (){}),
                          CategoryCard(label: 'Donut', icon: TIcon.donut, onTap: (){}),
                          CategoryCard(label: 'Salad', icon: TIcon.salad, onTap: (){}),
                          CategoryCard(label: 'Noodles', icon: TIcon.noodles, onTap: (){}),
                          CategoryCard(label: 'Sandwich', icon: TIcon.sandwich, onTap: (){}),
                          CategoryCard(label: 'Pasta', icon: TIcon.pasta, onTap: (){}),
                          CategoryCard(label: 'Ice Cream', icon: TIcon.iceCream, onTap: (){}),
                          CategoryCard(label: 'More', icon: TIcon.moreHoriz, onTap: (){}),
                        ],
                      ),
                      SizedBox(height: TSize.spaceBetweenSections,),

                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Special Offers', style: Theme.of(context).textTheme.headlineSmall),
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
                                      TIcon.arrowRight,
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
                                onTap: () {},
                                image: TImage.hcFood1,
                                name: "Chicken Burger",
                                stars: 4.9,
                                originalPrice: 10.00,
                                salePrice: 6.00,
                              ),
                              FoodCard(
                                onTap: () {},
                                image: TImage.hcFood1,
                                name: "Chicken Burger",
                                stars: 4.9,
                                originalPrice: 10.00,
                                salePrice: 6.00,
                              ),
                              FoodCard(
                                onTap: () {},
                                image: TImage.hcFood1,
                                name: "Chicken Burger",
                                stars: 4.9,
                                originalPrice: 10.00,
                                salePrice: 6.00,
                              ),
                              FoodCard(
                                onTap: () {},
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
