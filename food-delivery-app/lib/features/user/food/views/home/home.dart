import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/features/deliverer/menu_redirection.dart';
import 'package:food_delivery_app/features/restaurant/menu_redirection.dart';
import 'package:food_delivery_app/features/user/food/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/user/food/views/common/widgets/category_card.dart';
import 'package:food_delivery_app/features/user/food/views/home/widgets/home_sliver_app_bar.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        final menuController = UserMenuController.instance;
        $print(menuController.user);
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              HomeSliverAppBar(),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    MainWrapper(
                      child: Row(
                        children: [
                          if(menuController.user?.deliverer != null)...[
                            SmallButton(
                              text: "Shipper",
                              onPressed: () {
                                Get.offAll(() => DelivererMenuRedirection());
                              },
                            ),
                          ],
                          SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                          if(menuController.user?.restaurant != null)...[
                            SmallButton(
                              text: "Restaurant",
                              onPressed: () {
                                Get.offAll(() => RestaurantMenuRedirection());
                              },
                            )
                          ]
                        ],
                      ),
                    ),
                    SizedBox(height: TSize.spaceBetweenItemsVertical,),

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
                              CategoryCard(label: 'Burger', icon: TIcon.burger, onTap: () {controller.getToFoodCategory("Burger");}),
                              CategoryCard(label: 'Taco', icon: TIcon.taco, onTap: () {controller.getToFoodCategory("Taco");}),
                              CategoryCard(label: 'Burrito', icon: TIcon.burrito, onTap: () {controller.getToFoodCategory("Burrito");}),
                              CategoryCard(label: 'Drink', icon: TIcon.drink, onTap: () {controller.getToFoodCategory("Drink");}),
                              CategoryCard(label: 'Pizza', icon: TIcon.pizza, onTap: () {controller.getToFoodCategory("Pizza");}),
                              CategoryCard(label: 'Donut', icon: TIcon.donut, onTap: () {controller.getToFoodCategory("Donut");}),
                              CategoryCard(label: 'Salad', icon: TIcon.salad, onTap: () {controller.getToFoodCategory("Salad");}),
                              CategoryCard(label: 'Noodles', icon: TIcon.noodles, onTap: () {controller.getToFoodCategory("Noodles");}),
                              CategoryCard(label: 'Sandwich', icon: TIcon.sandwich, onTap: () {controller.getToFoodCategory("Sandwich");}),
                              CategoryCard(label: 'Pasta', icon: TIcon.pasta, onTap: () {controller.getToFoodCategory("Pasta");}),
                              CategoryCard(label: 'Ice Cream', icon: TIcon.iceCream, onTap: () {controller.getToFoodCategory("Ice Cream");}),
                              CategoryCard(label: 'More', icon: TIcon.moreHoriz, onTap: controller.getToFoodMore),
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
                                    onTap: () {
                                      controller.getToFoodCategory("Special Offers");
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('View All ', style:
                                        Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          color: TColor.primary,
                                          // fontWeight: FontWeight.w600
                                        )),
                                        Icon(
                                          TIcon.arrowForward,
                                          size: TSize.iconSm,
                                          color: TColor.primary,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // GridView.count(
                              //   crossAxisCount: 2,
                              //   crossAxisSpacing: 10,
                              //   mainAxisSpacing: 10,
                              //   childAspectRatio: 13 / 16,
                              //   shrinkWrap: true,
                              //   physics: NeverScrollableScrollPhysics(),
                              //   children: [
                              //     for(int i = 0; i < 4; i++)
                              //       FoodCard(
                              //         type: FoodCardType.grid,
                              //         onTap: () {},
                              //         heart: 'assets/icons/heart.svg',
                              //       )
                              //
                              //   ],
                              // ),
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
      },
    );
  }
}
