import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/list/restaurant_list.dart';
import 'package:food_delivery_app/features/deliverer/menu_redirection.dart';
import 'package:food_delivery_app/features/restaurant/menu_redirection.dart';
import 'package:food_delivery_app/features/user/food/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/user/food/views/common/widgets/category_card.dart';
import 'package:food_delivery_app/features/user/food/views/home/skeleton/home_skeleton.dart';
import 'package:food_delivery_app/features/user/food/views/home/widgets/home_sliver_app_bar.dart';
import 'package:food_delivery_app/features/user/food/views/restaurant/restaurant_search.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class HomeView extends StatelessWidget {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        final menuController = UserMenuController.instance;
        return
          Obx(() => controller.isLoading.value
              ? HomeViewSkeleton()
              : Scaffold(
            body: CustomScrollView(
              slivers: [
                HomeSliverAppBar(),

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      MainWrapper(
                        child: Row(
                          children: [
                            if(controller.user?.isCertifiedDeliverer ?? false)...[
                              SmallButton(
                                text: "Shipper",
                                onPressed: () {
                                  Get.offAll(() => DelivererMenuRedirection());
                                },
                              ),
                            ],
                            SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                            if(controller.user?.isCertifiedRestaurant ?? false)...[
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
                            CSearchBar(
                              controller: searchController,
                              prefixPressed: () {
                                Get.to(() => RestaurantSearchView(searchResult: searchController.text,));
                              },
                            ),

                            GridView.count(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                for (var category in THardCode.getCategory.entries)
                                  CategoryCard(
                                    label: category.value['label'],
                                    icon: category.value['icon'],
                                    onTap: () {
                                      if (category.key == 'More') {
                                        controller.getToFoodMore();
                                      } else {
                                        controller.getToFoodCategory(category.key);
                                      }
                                    },
                                  ),
                              ],
                            ),
                            SizedBox(height: TSize.spaceBetweenSections,),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          MainWrapper(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Special Offers', style: Theme.of(context).textTheme.headlineMedium),
                                GestureDetector(
                                  onTap: () {
                                    controller.getToFoodCategory("");
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
                          ),
                          SizedBox(height: TSize.spaceBetweenItemsVertical,),
                          RestaurantList(
                            searchBar: false,
                            tag: "home",
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
                ),
              ],
            ),
          ));
      },
    );
  }
}
