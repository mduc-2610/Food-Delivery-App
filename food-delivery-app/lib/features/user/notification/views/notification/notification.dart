import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/bars/menu_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/user/notification/views/notification/widgets/notification_item.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';

class NotificationView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> notificationList = THardCode.getNotificationList();
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Notification",
            iconList: [
              {
                "icon": Icons.more_horiz

              }
            ],
            noLeading: true,
          ),
          SliverToBoxAdapter(
            child: MainWrapper(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CSearchBar(),
                  SizedBox(height: TSize.spaceBetweenSections,),
                  Text(
                    "Not Found",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.textDesc),
                  ),
                  SizedBox(height: TSize.spaceBetweenSections,),
                  Text(
                    "Empty",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.textDesc),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      Column(
                        children: List.generate(
                          notificationList.length,
                              (index) => Container(
                            margin: EdgeInsets.only(
                              bottom: TSize.spaceBetweenItemsVertical,
                            ),
                            child: NotificationItem(
                              title: notificationList[index]["title"],
                              description: notificationList[index]["description"],
                              iconStr: notificationList[index]["iconStr"],
                              iconBgColor: notificationList[index]["iconBgColor"],
                              time: notificationList[index]["time"],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
