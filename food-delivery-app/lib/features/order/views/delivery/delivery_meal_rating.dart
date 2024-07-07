import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skip_button.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';


class DeliveryMealRatingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(title: 'Rate Your Meal'),
      body: MainWrapper(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  OrderIdWidget(),
                  MealRatingWidget(
                    mealName: 'Chicken Burger',
                    imageUrl: TImage.hcBurger1,
                    rating: 4,
                    review: 'Chicken burger is delicious! I will save it for next order.',
                  ),
                  MealRatingWidget(
                    mealName: 'Ramen Noodles',
                    imageUrl: TImage.hcBurger1,
                    rating: 5,
                  ),
                  MealRatingWidget(
                    mealName: 'Cherry Tomato Salad',
                    imageUrl: TImage.hcBurger1,
                    rating: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainWrapper(
        bottomMargin: TSize.spaceBetweenSections,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SkipButton(onPressed: () {},),
            ),
            SizedBox(width: TSize.spaceBetweenItemsHorizontal,),
            Expanded(child: ElevatedButton(
              onPressed: () {},
              child: Text('Submit'),
            ),)
          ],
        ),
      ),
    );
  }
}

class OrderIdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Order ID',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'SP 0023900',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}

class MealRatingWidget extends StatefulWidget {
  final String mealName;
  final String imageUrl;
  final int rating;
  final String? review;

  MealRatingWidget({
    required this.mealName,
    required this.imageUrl,
    required this.rating,
    this.review,
  });

  @override
  State<MealRatingWidget> createState() => _MealRatingWidgetState();
}

class _MealRatingWidgetState extends State<MealRatingWidget> {
  int _rating = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(widget.imageUrl, width: 80, height: 80)
                ),
                SizedBox(width: TSize.spaceBetweenItemsVertical),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.mealName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsHorizontal,),
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
                        itemSize: TSize.iconXl,
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsVertical),

                    ],
                  ),
                ),
              ],
            ),
            if (widget.review != null) Text(widget.review!),
            TextField(
              decoration: InputDecoration(
                hintText: 'Type your review ...',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
