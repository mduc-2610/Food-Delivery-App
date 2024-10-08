import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/features/notification/views/widgets/notification_item.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';

class NotificationTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> notificationList = THardCode.getNotificationList();

    return MainWrapper(
      child: ListView(
        padding: EdgeInsets.zero,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CSearchBar(),
          SizedBox(height: TSize.spaceBetweenSections,),
          // Text(
          //   "Not Found",
          //   style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.textDesc),
          //   textAlign: TextAlign.center,
          // ),
          // SizedBox(height: TSize.spaceBetweenSections,),
          // Text(
          //   "Empty",
          //   style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.textDesc),
          //   textAlign: TextAlign.center,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
    );
  }
}
