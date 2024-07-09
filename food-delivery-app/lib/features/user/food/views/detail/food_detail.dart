import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/features/user/food/controllers/detail/food_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/views/detail/widgets/food_detail_bottom_app_bar.dart';
import 'package:food_delivery_app/features/user/food/views/detail/widgets/food_detail_sliver_app_bar.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class FoodDetailView extends StatefulWidget {

  @override
  State<FoodDetailView> createState() => _FoodDetailViewState();
}

class _FoodDetailViewState extends State<FoodDetailView> {
  bool _x = false;
  final FoodDetailController _controller = Get.put(FoodDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          FoodDetailSliverAppBar(),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Stack(
                        children: [
                          Text(
                            "£10.00",
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: TColor.textDesc),
                          ),
                          Positioned(
                              bottom: 7,
                              child: SizedBox(
                                  width: 100,
                                  child: Divider(
                                    thickness: 3,
                                    color: TColor.textDesc,
                                  )
                              )
                          )
                        ],
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsVertical,),
                      Text(
                        "£6.00",
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary),
                      ),
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical,),

                  Row(
                    children: [
                      SvgPicture.asset(
                        TIcon.fillStar,
                        width: TSize.iconSm,
                        height: TSize.iconSm,
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                      Text(
                        '4.9 (1,205)',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: _controller.getToFoodReview,
                        child: Text(
                          "See all reviews",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ),
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),
                  Text(
                    'A delicious chicken burger served on a toasted bun with fresh lettuce, tomato slices, and mayonnaise. Juicy grilled chicken patty seasoned...',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {},
                          child: Text(
                            "See all",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          )
                      ),
                    ],
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical,),

                  Text(
                    'Additional Options:',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsVertical,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add Cheese "),
                      Row(
                        children: [
                          Text("+ £0.50"),
                          Checkbox(
                            onChanged: (e) {setState(() {
                              _x = e!;
                            });},
                            value: _x,
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add Bacon "),
                      Row(
                        children: [
                          Text("+ £0.50"),
                          Checkbox(
                            onChanged: (e) {setState(() {
                              _x = e!;
                            });},
                            value: _x,
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add Meat "),
                      Row(
                        children: [
                          Text("+ £0.50"),
                          Checkbox(
                            onChanged: (e) {setState(() {
                              _x = e!;
                            });},
                            value: _x,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FoodDetailBottomAppBar(),
    );
  }
}


