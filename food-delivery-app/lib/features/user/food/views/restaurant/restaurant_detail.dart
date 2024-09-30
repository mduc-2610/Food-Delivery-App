import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar/delivery_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/common/widgets/behavior/sticky_tab_bar_delegate.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/list/food_list.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/views/review/detail_review.dart';
import 'package:food_delivery_app/features/user/food/views/restaurant/widgets/restaurant_detail_skeleton.dart';
import 'package:food_delivery_app/features/user/food/views/restaurant/widgets/restaurant_detail_sliver_app_bar.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RestaurantDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantDetailController>(
      init: RestaurantDetailController(),
      builder: (controller) {
        final restaurant = controller.restaurant;
        final dishes = controller.dishes;
        final categories = controller.categories;
        final mapCategory = controller.mapCategory;
        final basicInfo = restaurant?.basicInfo;
        return Obx(() {
          if (controller.isLoading.value) {
            return RestaurantDetailSkeleton();
          }

          return Scaffold(
            body: NestedScrollView(
              controller: ScrollController(),
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                RestaurantDetailSliverAppBar(),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      MainWrapperSection(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${basicInfo?.name ?? ""}",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => DetailReviewView(
                                  reviewType: ReviewType.restaurant,
                                  item: restaurant,
                                ));
                              },
                              child: Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: restaurant?.rating ?? 0.0,
                                    itemBuilder: (context, index) => SvgPicture.asset(
                                      TIcon.fillStar,
                                    ),
                                    itemCount: 5,
                                    itemSize: TSize.iconSm,
                                  ),
                                  SizedBox(width: TSize.spaceBetweenItemsSm),
                                  Text(
                                    '${restaurant?.rating} (${restaurant?.totalReviews} reviews)',
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Icon(
                                    TIcon.arrowForward,
                                    size: TSize.iconSm,
                                  ),
                                  SizedBox(width: TSize.spaceBetweenItemsSm),
                                  SeparateBar(),
                                  SizedBox(width: TSize.spaceBetweenItemsSm),
                                  Icon(
                                    TIcon.clock,
                                    size: TSize.iconSm,
                                  ),
                                  SizedBox(width: TSize.spaceBetweenItemsSm),
                                  Text(
                                    '27 min',
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Spacer(),
                                  CircleIconCard(
                                    onTap: () {
                                      controller.toggleLike();
                                    },
                                    iconSize: TSize.iconSm,
                                    iconStr: controller.isLiked.value ? TIcon.fillHeart : TIcon.heart,
                                    elevation: TSize.cardElevation,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SeparateSectionBar(),
                      MainWrapperSection(
                        rightMargin: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Popular Dish",
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                            ),
                            SizedBox(height: TSize.spaceBetweenItemsVertical),
                            FoodList(dishes: dishes, direction: Direction.horizontal,)
                          ],
                        ),
                      ),
                      SeparateSectionBar(),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyTabBarDelegate(
                    TabBar(
                      controller: controller.tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      tabs: [
                        for (var category in categories)
                          Tab(text: "${category.name}")
                      ],
                    ),
                  ),
                ),
              ],
              body: TabBarView(
                controller: controller.tabController,
                children: [
                  for (var category in categories)
                    FoodList(dishes: mapCategory[category.name] ?? [])
                ],
              ),
            ),
            bottomNavigationBar: DeliveryBottomNavigationBar()
          );
        });
      },
    );
  }
}
