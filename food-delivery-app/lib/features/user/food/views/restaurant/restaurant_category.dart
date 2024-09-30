import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/bars/search_bar.dart';
import 'package:food_delivery_app/common/widgets/list/restaurant_list.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_category_controller.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RestaurantCategoryView extends StatelessWidget {
  final _controller = Get.put(RestaurantCategoryController());
  @override
  Widget build(BuildContext context) {
    String category = _controller.category.value;
    String? categoryIcon = THardCode.getCategory[category]?['icon'];
    return Scaffold(
      appBar: CAppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${category}",
              style: Get.textTheme.headlineMedium,
            ),
            SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

            if(categoryIcon != null)...[
              Image.asset(
                categoryIcon,
                width: TSize.iconXl,
                height: TSize.iconXl,
              )
            ]
          ],
        ),
        centerTitle: true,
        noLeading: (category == "Liked") ? true : false,
      ),
      body: Stack(
        children: [
          RestaurantList(category: category,),

        ],
      )
    );
  }
}
