import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skip_button.dart';
import 'package:food_delivery_app/features/order/views/rating/rating_driver.dart';
import 'package:food_delivery_app/features/order/views/rating/rating_driver_tip.dart';
import 'package:food_delivery_app/features/order/views/rating/widgets/rating_bottom.dart';
import 'package:food_delivery_app/features/order/views/rating/widgets/driver_information.dart';
import 'package:food_delivery_app/features/order/views/rating/widgets/rating_review.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';

class RatingDriverView extends StatefulWidget {
  @override
  _RatingDriverViewState createState() => _RatingDriverViewState();
}

class _RatingDriverViewState extends State<RatingDriverView> {
  int _rating = 0;

  void _submitRating() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RatingDriverView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(title: 'Driver Rating'),
      body: MainWrapper(
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DriverInformation(
                head: "Rate your driver\'s delivery service.",
              ),
              RatingReview(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: RatingBottom(
        skipOnPressed: () {
          Get.to(() => RatingDriverTipView());
        },
        submitOnPressed: () {
          Get.to(() => RatingDriverTipView());
        },
      ),
    );
  }
}
