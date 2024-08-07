import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/cards/container_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';

class OrderPromotionListView extends StatelessWidget {
  final List<Map<String, dynamic>> promotionActions = THardCode.getPromotionList();

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
