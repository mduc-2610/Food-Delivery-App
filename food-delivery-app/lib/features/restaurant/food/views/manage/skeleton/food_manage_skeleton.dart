import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

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
            tabs: List.generate(3, (index) => _buildSkeletonTab()),
          ),
        ),
        body: TabBarView(
          children: List.generate(3, (index) => _buildSkeletonList()),
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

  Widget _buildSkeletonList() {
    return ListView.separated(
      padding: EdgeInsets.all(TSize.spaceBetweenItemsSm),
      itemCount: 5,
      separatorBuilder: (context, index) => SizedBox(height: TSize.spaceBetweenItemsVertical),
      itemBuilder: (context, index) => _buildSkeletonCard(),
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BoxSkeleton(
            width: 100,
            height: 100,
            borderRadius: TSize.borderRadiusMd,
          ),
          SizedBox(width: TSize.spaceBetweenItemsHorizontal),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BoxSkeleton(width: 120, height: 20),
                BoxSkeleton(width: 80, height: 15),
                BoxSkeleton(width: 50, height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BoxSkeleton(width: 60, height: 20),
                    BoxSkeleton(width: 40, height: 40, borderRadius: 20), // Circle
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}