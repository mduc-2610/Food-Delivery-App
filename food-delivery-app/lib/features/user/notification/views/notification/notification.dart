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

class NotificationView extends StatelessWidget {
  List<Map<String, dynamic>> notificationList = [
    {
      "title": "Get 20% Discount Code",
      "description": "Get discount codes from sharing with friends.",
      "iconStr": TIcon.discount,
      "iconBgColor": TColor.iconBgInfo,
      "time": "12:20 19/05/2024"
    },
    {
      "title": "Get 10% Discount Code",
      "description": "Holiday discount code.",
      "iconStr": TIcon.discount,
      "iconBgColor": TColor.iconBgInfo,
      "time": "10:15 19/05/2024"
    },
    {
      "title": "Order Received",
      "description": "Order #SP_0023900 has been delivered successfully.",
      "iconStr": TIcon.receivedOrder,
      "iconBgColor": TColor.iconBgSuccess,
      "time": "10:15 19/05/2024"
    },
    {
      "title": "Order on the Way",
      "description": "Your delivery driver is on the way with your order.",
      "iconStr": TIcon.onTheWayOrder,
      "iconBgColor": TColor.iconBgSuccess,
      "time": "10:10 19/05/2024"
    },
    {
      "title": "Your Order is Confirmed",
      "description": "Your order #SP_0023900 has been confirmed.",
      "iconStr": TIcon.confirmedOrder,
      "iconBgColor": TColor.iconBgSuccess,
      "time": "09:59 19/05/2024"
    },
    {
      "title": "Order Successful",
      "description": "Order #SP_0023900 has been placed successfully.",
      "iconStr": TIcon.successfulOrder,
      "iconBgColor": TColor.iconBgSuccess,
      "time": "09:56 19/05/2024"
    },
    {
      "title": "Order Cancelled",
      "description": "Order #SP_0023450 has been cancelled.",
      "iconStr": TIcon.cancelledOrder,
      "iconBgColor": TColor.iconBgCancel,
      "time": "22:40 19/05/2024"
    },
    {
      "title": "Account Setup Successful",
      "description": "Congratulations! Your account setup was successful.",
      "iconStr": TIcon.successfulAccountSetup,
      "iconBgColor": TColor.iconBgSuccess,
      "time": "20:15 19/05/2024"
    },
    {
      "title": "Credit Card Connected",
      "description": "Congratulations! Your credit card has been successfully added.",
      "iconStr": TIcon.connectedCreditCard,
      "iconBgColor": TColor.iconBgSuccess,
      "time": "20:00 19/05/2024"
    },
    {
      "title": "Get 5% Discount Code",
      "description": "Discount code for new users.",
      "iconStr": TIcon.discount,
      "iconBgColor": TColor.iconBgInfo,
      "time": "11:10 19/05/2024"
    },
  ];

  @override
  Widget build(BuildContext context) {
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
