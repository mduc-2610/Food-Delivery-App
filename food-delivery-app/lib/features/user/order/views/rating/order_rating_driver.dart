import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/order/views/rating/order_rating_driver_tip.dart';
import 'package:food_delivery_app/features/user/order/views/rating/widgets/driver_information.dart';
import 'package:food_delivery_app/features/user/order/views/rating/widgets/rating_bottom.dart';
import 'package:food_delivery_app/features/user/order/views/rating/widgets/rating_review.dart';
import 'package:get/get.dart';

class OrderRatingDriverView extends StatefulWidget {
  @override
  _OrderRatingDriverViewState createState() => _OrderRatingDriverViewState();
}

class _OrderRatingDriverViewState extends State<OrderRatingDriverView> {
  int _rating = 0;

  void _submitRating() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderRatingDriverView()),
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
          Get.to(() => OrderRatingDriverTipView());
        },
        submitOnPressed: () {
          Get.to(() => OrderRatingDriverTipView());
        },
      ),
    );
  }
}
