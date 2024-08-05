import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/controllers/bars/filter_bar_controller.dart';
import 'package:food_delivery_app/common/widgets/bars/filter_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/app_bar/sliver_app_bar.dart';
import 'package:food_delivery_app/features/user/food/views/detail/widgets/food_detail_review_list.dart';
import 'package:food_delivery_app/features/user/food/views/detail/widgets/food_detail_review_rating_distribution.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/hardcode/hardcode.dart';
import 'package:get/get.dart';

class FoodDetailReviewView extends StatefulWidget {
  @override
  _FoodDetailReviewViewState createState() => _FoodDetailReviewViewState();
}

class _FoodDetailReviewViewState extends State<FoodDetailReviewView> {
    final FilterBarController _filterController = Get.put(FilterBarController("All"));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                CSliverAppBar(
                  title: "Reviews",
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      MainWrapper(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: TSize.spaceBetweenItemsHorizontal),
                                RatingBarIndicator(
                                  rating: 4.5,
                                  itemBuilder: (context, index) => SvgPicture.asset(
                                    TIcon.fillStar
                                  ),
                                  itemCount: 5,
                                  itemSize: TSize.iconLg,
                                ),
                                SizedBox(height: TSize.spaceBetweenItemsHorizontal),
                                Text(
                                  '(1,205)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: TDeviceUtil.getScreenWidth() * 0.45,
                              child: FoodDetailReviewRatingDistribution()
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),


                      MainWrapper(
                        rightMargin: 0,
                        child: FilterBar(
                          filters: ['All', 'Positive', 'Negative', '5', '4', '3', '2', '1'],
                          exclude: ['All', 'Positive', 'Negative'],
                          suffixIconStr: TIcon.unearnedStar,
                          suffixIconStrClicked: TIcon.fillStar,
                        ),
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),
                      
                      MainWrapper(
                        child: Obx(() => FoodDetailReviewList(
                          reviews: THardCode.getReviewList(),
                          filter: _filterController.selectedFilter.value,
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


