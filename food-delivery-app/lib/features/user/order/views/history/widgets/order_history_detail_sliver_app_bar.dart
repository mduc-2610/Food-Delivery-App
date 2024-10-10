import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar_scroll_behavior.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/food/views/restaurant/widgets/restaurant_detail_flexible_app_bar.dart';
import 'package:food_delivery_app/features/user/order/controllers/history/order_history_detail_controller.dart';
import 'package:food_delivery_app/features/user/order/views/basket/order_basket.dart';
import 'package:food_delivery_app/features/user/order/views/history/order_history_detail.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderHistoryDetailSliverAppBar extends StatelessWidget {
  final PreferredSizeWidget? bottom;

  const OrderHistoryDetailSliverAppBar({
    this.bottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 230,
      floating: false,
      pinned: true,
      title: AppBarScrollBehavior(
        child: Text(
          "My History",
          style: Get.textTheme.headlineMedium,
        ),
        isScrollHidden: false,
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: OrderHistoryDetailFlexibleAppBar(),
      ),
      bottom: bottom,
    );
  }
}

class OrderHistoryDetailFlexibleAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = OrderHistoryDetailController.instance;
    return Stack(
      fit: StackFit.expand,
      children: [
        AppBarScrollBehavior(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  width: TDeviceUtil.getScreenWidth(),
                  child: THelperFunction.getValidImage(
                      controller.order?.restaurant?.detailInfo?.coverImage
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: TSize.xl,
          right: 0,
          child: MainWrapper(
            child: Row(
              children: [
                AppBarScrollBehavior(
                  child: Row(
                    children: [
                      // CircleIconCard(
                      //   elevation: 0,
                      //   icon: TIcon.search,
                      //   backgroundColor: Colors.black.withOpacity(0.2),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

}