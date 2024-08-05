import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/common/widgets/behavior/sticky_tab_bar_delegate.dart';
import 'package:food_delivery_app/common/widgets/cards/food_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';


class RestaurantDetailSkeleton extends StatelessWidget {
  const RestaurantDetailSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  BoxSkeleton(height: 250, width: double.infinity),
                  SizedBox(height: TSize.spaceBetweenItemsSm),

                  MainWrapperSection(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BoxSkeleton(height: 30, width: 200),
                        SizedBox(height: TSize.spaceBetweenItemsSm),
                        Row(
                          children: [
                            BoxSkeleton(height: 20, width: 100),
                            Spacer(),
                            BoxSkeleton(height: 40, width: 40, borderRadius: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SeparateSectionBar(),

                  MainWrapperSection(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BoxSkeleton(height: 24, width: 120),
                        SizedBox(height: TSize.spaceBetweenItemsVertical),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: [
                                for(int i = 0; i < 10; i++)...[
                                  FoodCardListSkeleton()
                                ]
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                  SeparateSectionBar(),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: List.generate(
                    4,
                        (index) => Tab(
                      child: BoxSkeleton(height: 30, width: 80),
                    ),
                  ),
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: List.generate(
              4,
                  (index) => SingleChildScrollView(
                child: Column(
                  children: [
                    for(int i = 0; i < 10; i++)...[
                      FoodCardListSkeleton()
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
