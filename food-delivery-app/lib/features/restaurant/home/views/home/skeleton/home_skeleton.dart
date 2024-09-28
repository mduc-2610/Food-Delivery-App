import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/deliverer/home/views/home/widgets/delivery_card.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class HomeViewSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BoxSkeleton(height: 30, width: 120),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(TSize.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BoxSkeleton(height: 40, width: 100),
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),

                  Card(
                    elevation: TSize.cardElevation,
                    child: Padding(
                      padding: EdgeInsets.all(TSize.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BoxSkeleton(width: 100, height: 20),
                              BoxSkeleton(width: 80, height: 20),
                            ],
                          ),
                          SizedBox(height: TSize.spaceBetweenItemsVertical),
                          Row(
                            children: [
                              BoxSkeleton(width: TSize.iconSm, height: TSize.iconSm),
                              SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                              BoxSkeleton(width: 40, height: 20),
                              SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                              BoxSkeleton(width: 120, height: 20),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),

                  BoxSkeleton(height: 230, width: double.infinity),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BoxSkeleton(height: 30, width: 100),
                      SizedBox(width: TSize.spaceBetweenItemsVertical),
                      BoxSkeleton(height: 30, width: 50),
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),

                  Column(
                    children: List.generate(5, (index) => Column(
                      children: [
                        DeliveryCardSkeleton(),
                        SizedBox(height: TSize.spaceBetweenItemsVertical),

                      ],
                    ),),
                  )
                  // BoxSkeleton(height: 50, width: double.infinity),
                  // SizedBox(height: TSize.spaceBetweenItemsVertical),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
