import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skip_button.dart';
import 'package:food_delivery_app/features/order/views/rating/rating_driver.dart';
import 'package:food_delivery_app/features/order/views/rating/widgets/rating_bottom.dart';
import 'package:food_delivery_app/features/order/views/rating/widgets/rating_review.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class RatingOrderView extends StatefulWidget {
  @override
  _RatingOrderViewState createState() => _RatingOrderViewState();
}

class _RatingOrderViewState extends State<RatingOrderView> {
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
      appBar: CAppBar(title: 'Order Rating'),
      body: MainWrapper(
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: TSize.spaceBetweenSections),
              Text(
                'Rate your Experience',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TSize.spaceBetweenSections),

              Image.asset(
                TImage.deDiamond,
                width: TDeviceUtil.getScreenWidth() ,
                height: TDeviceUtil.getScreenHeight() * 0.2,
              ),
              SizedBox(height: TSize.spaceBetweenSections),

              RatingReview(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: RatingBottom(
        skipOnPressed: _submitRating,
        submitOnPressed: _submitRating,
      ),
    );
  }
}
