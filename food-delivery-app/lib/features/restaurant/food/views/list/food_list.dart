import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/food_card.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class FoodView extends StatefulWidget {
  @override
  _FoodViewState createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: 'My Food',
        noLeading: true,
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(text: 'All'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            padding: EdgeInsets.all(8.0),
            children: [
              for(int i = 0; i < 10; i++)...[
                FoodCard(
                  type: FoodCardType.list,
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical,),
              ]

            ],
          ),
        ],
      ),
    );
  }
}
