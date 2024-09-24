import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/behavior/sticky_tab_bar_delegate.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/user/food/controllers/review/detail_review_controller.dart';
import 'package:food_delivery_app/features/user/food/models/review/review.dart';
import 'package:food_delivery_app/features/user/food/views/review/skeleton/detail_review_view_skeleton.dart';
import 'package:food_delivery_app/features/user/food/views/review/widgets/detail_review_list.dart';
import 'package:food_delivery_app/features/user/food/views/review/widgets/detail_review_rating_distribution.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

enum ReviewType { food, restaurant, deliverer }

class DetailReviewView extends StatelessWidget {
  final ReviewType reviewType;
  final item;

  DetailReviewView({
    this.reviewType = ReviewType.food,
    required this.item,
  });

  dynamic getBuilder({builder}) {
    switch(reviewType) {
      case ReviewType.restaurant:
        return GetBuilder<RestaurantDetailReviewController>(
          init: RestaurantDetailReviewController(item: item),
          builder: builder,
        );
      case ReviewType.deliverer:
        return GetBuilder<DelivererDetailReviewController>(
          init: DelivererDetailReviewController(item: item),
          builder: builder,
        );
      default:
        return GetBuilder<FoodDetailReviewController>(
          init: FoodDetailReviewController(item: item),
          builder: builder,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getBuilder(
      builder: (controller) {
        final item = controller.item;
        return Obx(() => controller.isPageLoading.value
            ? DetailReviewViewSkeleton()
            : Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CSliverAppBar(title: "Reviews"),
                SliverToBoxAdapter(
                  child: MainWrapper(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${item?.rating ?? 0}',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: TSize.spaceBetweenItemsHorizontal),
                            RatingBarIndicator(
                              rating: item?.rating ?? 0,
                              itemBuilder: (context, index) =>
                                  SvgPicture.asset(TIcon.fillStar),
                              itemCount: 5,
                              itemSize: TSize.iconLg,
                            ),
                            SizedBox(height: TSize.spaceBetweenItemsHorizontal),
                            Text(
                              '(${item?.formatTotalReviews})',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                        Expanded(
                          child: DetailReviewRatingDistribution(item: item),
                        ),
                      ],
                    ),
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
                      onTap: controller.onTapTab,
                      tabs: List.generate(controller.tabTypes.length, (index) {
                        String type = controller.tabTypes[index];
                        return Obx(() {
                          bool isSelected = controller.currentTabIndex.value == index;
                          return Tab(
                            child: Row(
                              children: [
                                Text(type),
                                if (index > 2)
                                  SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                                if (index > 2)
                                  SvgPicture.asset(
                                    isSelected ? TIcon.fillStar : TIcon.star,
                                    width: TSize.iconSm,
                                    height: TSize.iconSm,
                                  ),
                              ],
                            ),
                          );
                        });
                      }),
                    ),
                  ),
                ),
              ];
            },
            body: MainWrapper(
                topMargin: TSize.spaceBetweenItemsVertical,
                child: Obx(() => controller.isReviewLoading.value
                    ? FoodReviewListSkeleton()
                    : TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.tabController,
                  children: [
                    for(var type in controller.tabTypes)...[
                      DetailReviewList(
                        controller: controller,
                        filter: type,
                      )
                    ]
                  ],
                )
                )
            ),
          ),
        )
        );
      },
    );
  }
}
