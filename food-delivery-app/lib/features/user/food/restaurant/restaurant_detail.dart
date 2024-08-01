import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/cards/food_card_gr.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/food/controllers/detail/food_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/restaurant/widgets/restaurant_detail_sliver_app_bar.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RestaurantDetailView extends StatefulWidget {
  @override
  State<RestaurantDetailView> createState() => _RestaurantDetailViewState();
}

class _RestaurantDetailViewState extends State<RestaurantDetailView>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  late List tabs;

  @override
  void initState() {
    super.initState();
    tabs = ['Asss', 'B', 'C', 'asd'];
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          RestaurantDetailSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                MainWrapperSection(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Baking Bread yah",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: 4.9,
                            itemBuilder: (context, index) => SvgPicture.asset(
                              TIcon.fillStar,
                            ),
                            itemCount: 5,
                            itemSize: TSize.iconSm,
                          ),
                          SizedBox(width: TSize.spaceBetweenItemsSm),
                          Text(
                            '4.9 (500+ reviews)',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Icon(
                            TIcon.arrowForward,
                            size: TSize.iconSm,
                          ),
                          SizedBox(width: TSize.spaceBetweenItemsSm),
                          SeparateBar(),
                          SizedBox(width: TSize.spaceBetweenItemsSm),
                          Icon(
                            TIcon.clock,
                            size: TSize.iconSm,
                          ),
                          SizedBox(width: TSize.spaceBetweenItemsSm),
                          Text(
                            '27 min',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Spacer(),
                          CircleIconCard(
                            iconSize: TSize.iconSm,
                            iconStr: TIcon.heart,
                            elevation: TSize.cardElevation,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SeparateSectionBar(),
                MainWrapperSection(
                  rightMargin: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Popular Dish",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < 5; i++) ...[
                              Container(
                                margin: EdgeInsets.only(left: TSize.spaceBetweenItemsHorizontal),
                                width: TDeviceUtil.getScreenWidth() * 0.9,
                                child: FoodCard(
                                  type: FoodCardType.list,
                                  name: 'Burger handrssss asdasdasdsddasdasdasdasdasdasdasd',
                                  image: TImage.hcBurger1,
                                  stars: 4.0,
                                  originalPrice: 8.0,
                                  salePrice: 5.0,
                                  onTap: () {},
                                  reviewCount: '1.2k',
                                  tag: 'popular',
                                ),
                              ),
                            ],
                          ],
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
            delegate: _StickyTabBarDelegate(
              TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: [
                  for(var x in tabs)...[
                    Tab(text: x,)
                  ]
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            for(int i = 0; i < tabs.length; i++)
              SingleChildScrollView(
                child: MainWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 13 / 16,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          for (int j = 0; j < 10; j++)
                            FoodCard(
                              type: FoodCardType.grid,
                              name: 'Burger',
                              image: TImage.hcBurger1,
                              stars: 4.0,
                              originalPrice: 8.0,
                              salePrice: 5.0,
                              onTap: () {},
                              reviewCount: '1.2k',
                              tag: 'popular',
                            ),
                        ],
                      ),
                      SizedBox(height: TSize.spaceBetweenSections,)
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }


}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  _StickyTabBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return _tabBar != oldDelegate._tabBar;
  }
}
