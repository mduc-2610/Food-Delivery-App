import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/bars/filter_bar_controller.dart';
import 'package:food_delivery_app/common/widgets/bars/filter_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/personal/controllers/help_center/personal_help_center_controller.dart';
import 'package:food_delivery_app/features/personal/views/help_center/widgets/personal_help_center_list.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class PersonalHelpCenterView extends StatelessWidget {
  final PersonalHelpCenterController controller = Get.put(PersonalHelpCenterController());
  final FilterBarController _filterBarController = Get.put(FilterBarController("General", (_) async {}));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Help Center",
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                MainWrapper(
                  child: CSearchBar(),
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical,),

                // MainWrapper(
                //   rightMargin: 0,
                //   child: FilterBar(
                //     filters: ["General", "Account", "Ordering", "Payment"],
                //   ),
                // ),
                SizedBox(height: TSize.spaceBetweenItemsVertical,),

                MainWrapper(
                  child: PersonalHelpCenterList(
                    reviews: [
                      {
                        "text": "How do I create a new account?"
                      },
                      {
                        "text": "How do I create a new account?"
                      },
                      {
                        "text": "How do I create a new account?"
                      },
                      {
                        "text": "How do I create a new account?"
                      },
                      {
                        "text": "How do I create a new account?"
                      },
                      {
                        "text": "How do I create a new account?"
                      },
                    ],
                    filter: ""
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
