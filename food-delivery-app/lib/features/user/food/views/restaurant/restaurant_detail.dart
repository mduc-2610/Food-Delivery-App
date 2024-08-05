import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_section_bar.dart';
import 'package:food_delivery_app/common/widgets/behavior/sticky_tab_bar_delegate.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/list/food_list.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/views/restaurant/widgets/restaurant_detail_skeleton.dart';
import 'package:food_delivery_app/features/user/food/views/restaurant/widgets/restaurant_detail_sliver_app_bar.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:get/get.dart';

class RestaurantDetailView extends StatefulWidget {
  @override
  State<RestaurantDetailView> createState() => _RestaurantDetailViewState();
}

class _RestaurantDetailViewState extends State<RestaurantDetailView>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  bool _isMounted = true;
  late final _restaurantController;
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _restaurantController = Get.put(RestaurantDetailController());
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(Duration(milliseconds: TTime.init));
    if (_isMounted) {
      setState(() {
        _isLoading = false;
      });
    }
    _tabController = TabController(length: _restaurantController.categories.length, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = _restaurantController.restaurant;
    final dishes = _restaurantController?.dishes;
    final categories = _restaurantController.categories;
    final mapCategory = _restaurantController.mapCategory;
    final basicInfo = restaurant?.basicInfo;

    return
      (_isLoading) ? RestaurantDetailSkeleton()
      : Scaffold(
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
                        "${basicInfo.name ?? ""}",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: restaurant?.rating,
                            itemBuilder: (context, index) => SvgPicture.asset(
                              TIcon.fillStar,
                            ),
                            itemCount: 5,
                            itemSize: TSize.iconSm,
                          ),
                          SizedBox(width: TSize.spaceBetweenItemsSm),
                          Text(
                            '${restaurant?.rating} (${restaurant?.totalReviews} reviews)',
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
                      FoodList(dishes: dishes, direction: Direction.horizontal,)
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
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: [
                  for(var category in categories)...[
                    Tab(text: "${category?.name}")
                  ]
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            for(var category in categories)
              FoodList(dishes: mapCategory[category.name] ?? [])
          ],
        ),
      ),
    );
  }
}
