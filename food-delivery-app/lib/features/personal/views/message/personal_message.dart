import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/personal/views/message/widgets/message_item.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';

class PersonalMessageView extends StatelessWidget {
  List<Map<String, dynamic>> messageList = THardCode.getMessageList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Messages",
            iconList: [
              {
                "icon": Icons.more_horiz

              }
            ],
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
                      Column(
                        children: List.generate(
                          messageList.length,
                              (index) => Container(
                            margin: EdgeInsets.only(
                              bottom: TSize.spaceBetweenItemsVertical,
                            ),
                            child: MessageItem(
                              title: messageList[index]["title"],
                              description: messageList[index]["description"],
                              iconStr: messageList[index]["iconStr"],
                              iconBgColor: messageList[index]["iconBgColor"],
                              time: messageList[index]["time"],
                              avatar: TIcon.burger,
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
