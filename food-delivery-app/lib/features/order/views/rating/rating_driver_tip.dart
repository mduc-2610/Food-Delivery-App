import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skip_button.dart';
import 'package:food_delivery_app/features/order/views/rating/rating_meal.dart';
import 'package:food_delivery_app/features/order/views/rating/rating_meal.dart';
import 'package:food_delivery_app/features/order/views/rating/widgets/rating_bottom.dart';
import 'package:food_delivery_app/features/order/views/rating/widgets/driver_information.dart';
import 'package:food_delivery_app/features/order/views/rating/widgets/driver_tip.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

class RatingDriverTipView extends StatefulWidget {
  @override
  _RatingDriverTipViewState createState() => _RatingDriverTipViewState();
}

class _RatingDriverTipViewState extends State<RatingDriverTipView> {
  int selectedAmount = -1;
  TextEditingController customAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(title: "Give Thanks",),
      body: MainWrapper(
        child: Center(
          child: Column(
            children: [
              DriverInformation(
                head: 'Tip your delivery driver',
              ),

              SizedBox(height: TSize.spaceBetweenItemsVertical),

              DriverTip(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: RatingBottom(
        skipOnPressed: () {
          Get.to(RatingMealView());
        },
        submitOnPressed: () {
          Get.to(RatingMealView());
        },
        text1: "No, thanks!",
      )
    );
  }
}