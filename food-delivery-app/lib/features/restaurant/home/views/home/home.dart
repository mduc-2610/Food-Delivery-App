import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/deliverer/home/views/home/widgets/delivery_card.dart';
import 'package:food_delivery_app/features/restaurant/home/views/common/widgets/revenue_stats.dart';
import 'package:food_delivery_app/features/restaurant/home/views/home/skeleton/home_skeleton.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/utils/constants/emojis.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/restaurant/home/controllers/home/home_controller.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/features/restaurant/home/views/home/widgets/review_summary.dart';
import 'package:food_delivery_app/features/user/food/views/review/detail_review.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/misc/head_with_action.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantHomeController>(
      init: RestaurantHomeController(),
      builder: (controller) {
        return Obx(() => controller.isLoading.value
            ? HomeViewSkeleton()
            : Scaffold(
          appBar: CAppBar(
            title: "Welcome back  ${controller.restaurant?.basicInfo?.name} ${TEmoji.smilingFaceWithHeart}!",
            noLeading: true,
          ),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: MainWrapper(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SmallButton(
                            paddingHorizontal: 12,
                            onPressed: () { Get.offAll(() => UserMenuRedirection()); },
                            text: "User",
                          ),
                        ],
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),

                      // Review summary card
                      Card(
                        elevation: TSize.cardElevation,
                        child: Padding(
                          padding: EdgeInsets.all(TSize.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadWithAction(
                                title: "Reviews",
                                actionText: "See all reviews",
                                onActionTap: () {
                                  Get.to(() => DetailReviewView(
                                    reviewType: ReviewType.restaurant,
                                    item: controller.restaurant,
                                    viewType: ViewType.restaurant,
                                  ));
                                },
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    TIcon.fillStar,
                                    width: TSize.iconSm,
                                    height: TSize.iconSm,
                                  ),
                                  SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                                  Text(
                                    '${controller.restaurant?.rating}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(color: TColor.star),
                                  ),
                                  SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                                  Text(
                                      ' Total ${controller.restaurant?.formatTotalReviews} Reviews'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),

                      RevenueStats(
                        controller: RestaurantHomeController.instance,
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyTabBarDelegate(
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,

                    child: MainWrapper(
                      child: HeadWithAction(
                        title: "Latest delivery requests",
                        actionText: "See all",
                        onActionTap: () {
                          // Action for viewing all delivery requests
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
            body: MainWrapper(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var _delivery in controller.deliveries) ...[
                      DeliveryCard(
                        delivery: _delivery,
                        isTracking: false,
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}
class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxExtent,
      child: this.child,
    );
  }

  @override
  double get maxExtent => 70; // Fixed height

  @override
  double get minExtent => 70; // Fixed height

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

