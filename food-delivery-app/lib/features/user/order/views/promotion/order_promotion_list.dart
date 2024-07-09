import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/cards/container_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class OrderPromotionListView extends StatelessWidget {
  final List<Map<String, dynamic>> promotionActions = [
    {'icon': Icons.share, 'title': 'Share App'},
    {'icon': Icons.person_add, 'title': 'Invite Friends'},
    {'icon': Icons.shopping_cart, 'title': 'Complete Purchases'},
    {'icon': Icons.ondemand_video, 'title': 'Watch Ads'},
    {'icon': Icons.event, 'title': 'Participate in Events'},
    {'icon': Icons.account_circle, 'title': 'Complete Profile'},
    {'icon': Icons.follow_the_signs, 'title': 'Follow Social Media'},
    {'icon': Icons.question_answer, 'title': 'Take Surveys'},
    {'icon': Icons.emoji_events, 'title': 'Achieve Levels'},
    {'icon': Icons.devices_other_rounded, 'title': 'Daily Logins'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
              title: "Get More Promotions"
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return MainWrapper(
                  bottomMargin: TSize.spaceBetweenItemsVertical,
                  child: ContainerCard(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(promotionActions[index]['icon'], color: Colors.orange),
                      title: Text(promotionActions[index]['title']),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        // Handle the tap
                      },
                    ),
                  ),
                );
              },
              childCount: promotionActions.length,
            ),
          ),
        ],
      ),
    );
  }
}
