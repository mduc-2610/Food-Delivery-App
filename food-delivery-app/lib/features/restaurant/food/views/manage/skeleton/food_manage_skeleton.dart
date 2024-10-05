import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/restaurant/food/views/manage/skeleton/promotion_manage_card_skeleton.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class FoodManageSkeleton extends StatelessWidget {
  const FoodManageSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: BoxSkeleton(width: 100, height: 30),
          centerTitle: true,
          bottom: TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            tabs: List.generate(5, (index) => _buildSkeletonTab()),
          ),
        ),
        body: TabBarView(
          children: List.generate(5, (index) => _buildSkeletonList(index)),
        ),
      ),
    );
  }

  Widget _buildSkeletonTab() {
    return Tab(
      child: BoxSkeleton(
        width: 80,
        height: 30,
        borderRadius: TSize.borderRadiusMd,
      ),
    );
  }

  Widget _buildSkeletonList(int _index) {
    return ListView.separated(
      padding: EdgeInsets.all(TSize.spaceBetweenItemsSm),
      itemCount: 5,
      separatorBuilder: (context, index) => SizedBox(height: TSize.spaceBetweenItemsVertical),
      itemBuilder: (context, index) => _buildSkeletonCard(_index),
    );
  }

  Widget _buildSkeletonCard(int index) {
    return
      (index == 0)
      ? PromotionManageCardSkeleton(viewType: ViewType.restaurant)
      : Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSize.borderRadiusLg),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BoxSkeleton(
              height: TSize.imageThumbSize + 30,
              width: TSize.imageThumbSize + 30,
              borderRadius: TSize.borderRadiusMd,
            ),
            SizedBox(width: TSize.spaceBetweenItemsHorizontal),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoxSkeleton(
                    height: 20,
                    width: TDeviceUtil.getScreenWidth() * 0.5,
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BoxSkeleton(
                        height: TSize.iconSm,
                        width: TSize.iconSm,
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsSm),
                      BoxSkeleton(
                        height: 20,
                        width: TDeviceUtil.getScreenWidth() * 0.1,
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                      BoxSkeleton(
                        height: TSize.iconSm,
                        width: TSize.iconSm,
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsSm),
                      BoxSkeleton(
                        height: 20,
                        width: TDeviceUtil.getScreenWidth() * 0.1,
                      ),
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsSm),
                  Row(
                    children: [
                      BoxSkeleton(
                        height: TSize.iconSm,
                        width: TSize.iconSm,
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsSm),
                      BoxSkeleton(
                        height: 20,
                        width: TDeviceUtil.getScreenWidth() * 0.2,
                      ),
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsMd),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          BoxSkeleton(
                            height: 20,
                            width: TDeviceUtil.getScreenWidth() * 0.1,
                          ),
                          SizedBox(width: TSize.spaceBetweenItemsMd),
                          BoxSkeleton(
                            height: 20,
                            width: TDeviceUtil.getScreenWidth() * 0.1,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoxSkeleton(
                  height: TSize.iconLg,
                  width: TSize.iconLg,
                  borderRadius: TSize.borderRadiusCircle,
                ),
                SizedBox(height: TSize.spaceBetweenItemsMd),
                BoxSkeleton(
                  height: 20,
                  width: TDeviceUtil.getScreenWidth() * 0.2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}