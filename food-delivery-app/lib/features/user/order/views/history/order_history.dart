import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/filter_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/order_history_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
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
          appBar: CAppBar(
            title: "Orders",
            noLeading: true,
          ),
          body: Column(
            children: [
              Column(
                children: [
                  MainWrapper(child: CSearchBar(
                    controller: controller.searchController,
                    prefixPressed: controller.handleSearch,
                  )),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),
                  MainWrapper(
                    rightMargin: 0,
                    child: FilterBar(
                      controller: controller.filterBarController,
                      filters: ["All", "Active", "Completed", "Cancelled", "5", "4", "3", "2", "1"],
                      exclude: ["All", "Active", "Completed", "Cancelled"],
                      suffixIconStr: TIcon.unearnedStar,
                      suffixIconStrClicked: TIcon.fillStar,
                    ),
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),
                ],
              ),

              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.isLoading.value
                        ? 6
                        : controller.orders.length,
                    itemBuilder: (context, index) {
                      if (controller.isLoading.value) {
                        return OrderHistoryCardSkeleton();
                      } else {
                        return OrderHistoryCard(order: controller.orders[index]);
                      }
                    },
                  );
                }),
              ),
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
    this.length = 10,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: length,
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

