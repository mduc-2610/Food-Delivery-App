import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skip_button.dart';
import 'package:food_delivery_app/features/order/views/delivery/delivery_driver_rating.dart';
import 'package:food_delivery_app/features/order/views/delivery/delivery_driver_tip.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';

class DeliveryDriverRatingView extends StatefulWidget {
  @override
  _DeliveryDriverRatingViewState createState() => _DeliveryDriverRatingViewState();
}

class _DeliveryDriverRatingViewState extends State<DeliveryDriverRatingView> {
  int _rating = 0;

  void _submitRating() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeliveryDriverRatingView()),
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
              SizedBox(height: TSize.spaceBetweenSections),
              Text(
                'Rate your driver\'s delivery service.',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: TSize.spaceBetweenSections),

              CircleAvatar(
                radius: TSize.imageThumbSize,
                backgroundImage: AssetImage(TImage.hcBurger1),
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
              Text(
                'David Wayne',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary),
              ),
              Text(
                'Driver',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: TSize.spaceBetweenSections),

              RatingBarIndicator(
                itemPadding: EdgeInsets.only(right: TSize.spaceBetweenItemsHorizontal),
                rating: _rating.toDouble(),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                  child: SvgPicture.asset(
                    TIcon.fillStar,
                  ),
                ),
                itemCount: 5,
                itemSize: 65,
              ),
              SizedBox(height: TSize.spaceBetweenSections),

              if(_rating != 0)...[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Type your review...',
                    hintStyle: TextStyle(

                    )
                  ),
                  maxLines: TSize.inputMaxLines,
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainWrapper(
        bottomMargin: TSize.spaceBetweenSections,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SkipButton(onPressed: () {
                Get.to(DeliveryDriverTipView());
              },),
            ),
            SizedBox(width: TSize.spaceBetweenItemsHorizontal,),
            Expanded(child: ElevatedButton(
              onPressed: () {
                Get.to(DeliveryDriverTipView());
              },
              child: Text('Submit'),
            ),)
          ],
        ),
      ),
    );
  }
}
