import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/app_bar/delivery_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/fields/date_picker.dart';
import 'package:food_delivery_app/common/widgets/misc/head_with_action.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/deliverer/home/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/deliverer/home/views/home/skeleton/home_skeleton.dart';
import 'package:food_delivery_app/features/deliverer/home/views/home/widgets/delivery_card.dart';
import 'package:food_delivery_app/features/user/food/views/review/detail_review.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/emojis.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DelivererHomeController>(
      init: DelivererHomeController(),
      builder: (controller) {
        return controller.isLoading.value
            ? HomeViewSkeleton()
            : Scaffold(
          appBar: CAppBar(
            title: "Hello, ${controller.deliverer?.basicInfo?.givenName} ${controller.deliverer?.basicInfo?.fullName} ${TEmoji.smilingFaceWithHeart}",
            noLeading: true,
            textStyle: Theme.of(context).textTheme.headlineSmall,
          ),
          body: NestedScrollView(
            controller: controller.scrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: MainWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        child: SmallButton(
                          paddingHorizontal: 0,
                          onPressed: () {
                            Get.offAll(() => UserMenuRedirection());
                          },
                          text: "User",
                        ),
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      Card(
                        elevation: TSize.cardElevation,
                        child: Padding(
                          padding: EdgeInsets.all(TSize.md),
                          child: Column(
                            children: [
                              HeadWithAction(
                                title: "Reviews",
                                actionText: "See all reviews",
                                onActionTap: () {
                                  Get.to(() => DetailReviewView(reviewType: ReviewType.deliverer));
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
                                    '${controller.deliverer?.rating}',
                                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: TColor.star),
                                  ),
                                  SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                                  Text(' Total ${controller.deliverer?.formatTotalReviews} Reviews'),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                      child: Column(
                        children: [
                          HeadWithAction(
                            title: "Order History",
                            action: Expanded(
                              child: CDatePicker(
                                labelText: "Choose Date",
                                controller: TextEditingController(
                                  text: controller.selectedDate.value != null
                                      ? DateFormat('yyyy-MM-dd').format(controller.selectedDate.value!)
                                      : '',
                                ),
                                onDateSelected: (date) {
                                  controller.filterDeliveriesByDate(date);
                                },
                              ),
                            ),
                          ),
                          // SizedBox(height: TSize.spaceBetweenItemsVertical),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
            body: MainWrapper(
                child:
                // ListView.builder(
                //   padding: EdgeInsets.zero,
                //   controller: controller.scrollController,
                //   // physics: NeverScrollableScrollPhysics(),
                //   itemCount: controller.deliveryRequests.length,
                //   itemBuilder: (context, index) {
                //     final deliveryRequest = controller.deliveryRequests[index];
                //     return DeliveryCard(
                //       deliveryRequest: deliveryRequest,
                //       isTracking: false,
                //     );
                //   },
                //   primary: false,
                //   shrinkWrap: true,
                // ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      for(var deliveryRequest in controller.deliveryRequests)...[
                        DeliveryCard(
                          deliveryRequest: deliveryRequest,
                          isTracking: false,
                        )
                      ]
                    ],
                  ),
                )
            ),
          ),
        );
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



