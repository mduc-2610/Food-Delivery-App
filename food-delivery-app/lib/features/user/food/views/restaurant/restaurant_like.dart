import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/list/restaurant_list.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';

class RestaurantLikeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Liked",
            noLeading: true,
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Column(
                  children: [
                    RestaurantList(
                      isLike: true,
                      tag: "like",
                    ),

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
