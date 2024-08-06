import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/behavior/sticky_tab_bar_delegate.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/user/food/controllers/detail/food_detail_review_controller.dart';
import 'package:food_delivery_app/features/user/food/views/detail/skeleton/food_detail_review_view_skeleton.dart';
import 'package:food_delivery_app/features/user/food/views/detail/widgets/food_detail_review_list.dart';
import 'package:food_delivery_app/features/user/food/views/detail/widgets/food_detail_review_rating_distribution.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class FoodDetailReviewView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodDetailReviewController>(
      init: FoodDetailReviewController(),
      builder: (controller) {
        final dish = controller.dish;
        return Obx(() =>
        controller.isPageLoading.value
            ? FoodDetailReviewViewSkeleton()
            : Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
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
                            '${dish?.rating}',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: TSize.spaceBetweenItemsHorizontal),
                          RatingBarIndicator(
                            rating: dish?.rating ?? 0,
                            itemBuilder: (context, index) =>
                                SvgPicture.asset(TIcon.fillStar),
                            itemCount: 5,
                            itemSize: TSize.iconLg,
                          ),
                          SizedBox(height: TSize.spaceBetweenItemsHorizontal),
                          Text(
                            '(${dish?.formatTotalReviews})',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                      Expanded(
                        child: FoodDetailReviewRatingDistribution(dish: dish),
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
              SliverFillRemaining(
                child: MainWrapper(
                  child: Obx(() => controller.isReviewLoading.value
                      ? FoodReviewListSkeleton()
                      : TabBarView(
                    controller: controller.tabController,
                    children: controller.tabTypes.map((type) {
                      return FoodDetailReviewList(
                        reviews: controller.reviews,
                        filter: type,
                      );
                    }).toList(),
                  )),
                ),
              ),
            ],
          ),
        ));
      },
    );
  }
}
