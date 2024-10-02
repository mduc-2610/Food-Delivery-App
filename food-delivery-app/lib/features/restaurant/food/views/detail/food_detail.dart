import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/controllers/bars/filter_bar_controller.dart';
import 'package:food_delivery_app/common/widgets/app_bar/delivery_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/filter_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/round_icon_button.dart';
import 'package:food_delivery_app/common/widgets/cards/order_history_card.dart';
import 'package:food_delivery_app/features/personal/views/profile/profile.dart';
import 'package:food_delivery_app/features/restaurant/food/controllers/detail/food_detail_controller.dart';
import 'package:food_delivery_app/features/restaurant/food/views/detail/skeleton/food_detail_skeleton.dart';
import 'package:food_delivery_app/features/user/food/views/review/detail_review.dart';
import 'package:food_delivery_app/features/user/food/views/review/skeleton/detail_review_skeleton.dart';
import 'package:food_delivery_app/features/user/food/views/detail/widgets/food_detail_sliver_app_bar.dart';
import 'package:food_delivery_app/features/user/order/views/history/order_history_detail.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class FoodDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantFoodDetailController>(
      init: RestaurantFoodDetailController(),
      builder: (controller) {
        final dish = controller.dish;
        return Obx(() => (controller.isLoading.value)
            ? FoodDetailSkeleton()
            : Scaffold(
          body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  FoodDetailSliverAppBar(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${dish?.name}",
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Text(
                                          "£${dish?.discountPrice}",
                                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: TColor.textDesc),
                                        ),
                                        Positioned(
                                          bottom: 7,
                                          child: SizedBox(
                                            width: 100,
                                            child: Divider(
                                              thickness: 3,
                                              color: TColor.textDesc,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: TSize.spaceBetweenItemsVertical),
                                    Text(
                                      "£${dish?.originalPrice}",
                                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: TColor.primary),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: TSize.spaceBetweenItemsVertical),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [],
                              ),
                            ],
                          ),
                          SizedBox(height: TSize.spaceBetweenItemsVertical),
                          Row(
                            children: [
                              SvgPicture.asset(
                                TIcon.fillStar,
                                width: TSize.iconSm,
                                height: TSize.iconSm,
                              ),
                              Text(
                                ' ${dish?.rating} ',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.star),
                              ),
                              Text(
                                '(${dish?.totalReviews} reviews)',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => DetailReviewView(item: dish,));
                                },
                                child: Text(
                                  "See all reviews",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: TSize.spaceBetweenItemsVertical),
                          Text(
                            '${dish?.description}',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: StickyTabBarDelegate(
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(16),
                        child: FilterBar(
                          filters: ["All", "Active", "Completed", "Cancelled"],
                          exclude: ["All", "Active", "Completed", "Cancelled"],
                          suffixIconStr: TIcon.unearnedStar,
                          suffixIconStrClicked: TIcon.fillStar,
                          controller: FilterBarController("all", (_) async {}),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    for(var order in controller.orders)...[
                      OrderHistoryCard(
                        order: order,
                        onTap: () {
                          Get.to(() => OrderHistoryDetailView(viewType: ViewType.deliverer,), arguments: {
                            "id": order.id
                          });
                        },
                      )
                    ]
                  ],
                ),
              )
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
    return this.child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
