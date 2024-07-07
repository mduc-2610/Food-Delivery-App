import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/controllers/filter_bar_controller.dart';
import 'package:food_delivery_app/common/widgets/bars/filter_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/order/views/history/order_history_detail.dart';
import 'package:food_delivery_app/features/order/views/history/widgets/order_history_list.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';

class OrderHistoryView extends StatefulWidget {
  @override
  _OrderHistoryViewState createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  final FilterBarController _filterBarController = Get.put(FilterBarController("All"));

  final List<Map<String, dynamic>> orders = [
    {
      'id': 'SP 0023900',
      'image': TImage.hcBurger1,
      'price': 25.20,
      'rating': 4,
      'status': 'Active',
    },
    {
      'id': 'SP 0023512',
      'image': TImage.hcBurger1,
      'price': 40.00,
      'rating': 5,
      'status': 'Completed',
    },
    {
      'id': 'SP 0023502',
      'image': TImage.hcBurger1,
      'price': 85.00,
      'rating': 4,
      'status': 'Completed',
    },
    {
      'id': 'SP 0023450',
      'image': TImage.hcBurger1,
      'price': 20.50,
      'rating': 3,
      'status': 'Cancelled',
    },

    {
      'id': 'SP 0023450',
      'image': TImage.hcBurger1,
      'price': 20.50,
      'rating': 2,
      'status': 'Cancelled',
    },

    {
      'id': 'SP 0023450',
      'image': TImage.hcBurger1,
      'price': 20.50,
      'rating': 2,
      'status': 'Cancelled',
    },

    {
      'id': 'SP 0023450',
      'image': TImage.hcBurger1,
      'price': 20.50,
      'rating': 1,
      'status': 'Cancelled',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CSliverAppBar(
            title: "Orders"
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                MainWrapper(child: CSearchBar()),
                SizedBox(height: TSize.spaceBetweenItemsVertical,),

                MainWrapper(
                  rightMargin: 0,
                  child: FilterBar(
                    filters: ["All", "Active", "Completed", "Cancelled", "5", "4", "3", "2", "1"],
                    exclude: ["All", "Active", "Completed", "Cancelled"],
                    suffixIconStr: TIcon.unearnedStar,
                    suffixIconStrClicked: TIcon.fillStar,
                  ),
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical,),

                MainWrapper(
                  child: Container(
                    height: 1000,
                    child: Obx(() => OrderHistoryList(
                      orders: orders,
                      selectedFilter: _filterBarController.selectedFilter.value,
                    )
                    ))
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

}
