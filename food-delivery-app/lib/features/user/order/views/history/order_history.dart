import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/filter_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/order_history_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/authentication/views/splash/splash.dart';
import 'package:food_delivery_app/features/user/order/controllers/history/order_history_controller.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class OrderHistoryView extends StatefulWidget {
  @override
  _OrderHistoryViewState createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderHistoryController>(
      init: OrderHistoryController(),
      builder: (controller) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              CSliverAppBar(
                title: "Orders",
                noLeading: true,
              ),

              SliverPersistentHeader(
                pinned: true,
                delegate: MySliverHeaderDelegate(
                  child: Column(
                    children: [
                      MainWrapper(child: CSearchBar()),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      MainWrapper(
                        rightMargin: 0,
                        child: FilterBar(
                          filters: ["All", "Active", "Completed", "Cancelled", "5", "4", "3", "2", "1"],
                          exclude: ["All", "Active", "Completed", "Cancelled"],
                          suffixIconStr: TIcon.unearnedStar,
                          suffixIconStrClicked: TIcon.fillStar,
                          onTap: controller.fetchFilterOrder,
                        ),
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                    ],
                  ),
                ),
              ),

              Obx(() {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      if (controller.isLoading.value) {
                        return OrderHistoryCardSkeleton();
                      } else {
                        if (index < controller.restaurantCarts.length) {
                          return OrderHistoryCard(restaurantCart: controller.restaurantCarts[index]);
                        } else {
                          return SizedBox.shrink();
                        }
                      }
                    },
                    childCount: controller.isLoading.value
                        ? 5
                        : controller.restaurantCarts.length,
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

}

class OrderHistoryListSkeleton extends StatelessWidget {
  final int length;
  const OrderHistoryListSkeleton({
    this.length = 5,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 5,
            (context, index) {
          return OrderHistoryCardSkeleton();
        },
      ),
    );
  }
}



class MySliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final Color? backgroundColor;

  MySliverHeaderDelegate({required this.child, this.backgroundColor});

  @override
  double get minExtent => 140.0;
  @override
  double get maxExtent => 140.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      child: SizedBox.expand(child: child),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

