import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/show_success_dialog.dart';
import 'package:food_delivery_app/common/widgets/skip_button.dart';
import 'package:food_delivery_app/features/order/views/rating/widgets/meal_rating_card.dart';
import 'package:food_delivery_app/features/order/views/rating/widgets/rating_bottom.dart';
import 'package:food_delivery_app/utils/constants/emoji.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';


class RatingMealView extends StatelessWidget {
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
                  SizedBox(height: TSize.spaceBetweenItemsVertical,),
                  MealRatingCard(
                    mealName: 'Chicken Burger',
                    imageUrl: TImage.hcBurger1,
                    rating: 4,
                    review: 'Chicken burger is delicious! I will save it for next order.',
                  ),
                  MealRatingCard(
                    mealName: 'Ramen Noodles',
                    imageUrl: TImage.hcBurger1,
                    rating: 5,
                  ),
                  MealRatingCard(
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
      bottomNavigationBar: RatingBottom(
        skipOnPressed: () {},
        submitOnPressed: () {
          showSuccessDialog(
            context,
            image: TImage.diaHeart,
            head: "Big Thanks ${TEmoji.smilingFaceWithHeart}",
            title: "Thanks for rating our meal",
            description: "We appreciate your time and hope to serve you again soon!",
          );
          showSuccessDialog(
            context,
            image: TImage.diaClover,
            head: "Delivery Successful ${TEmoji.faceSavoringFood}",
            title: "Enjoy Your Meal!",
            description: "See you in the next order!",
          );
          showSuccessDialog(
            context,
            image: TImage.diaConfetti,
            head: "Payment Successful ${TEmoji.starStruck}",
            title: "Thank you for your order!",
            description: "Your payment has been successfully processed.",
          );
        },
      )
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
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            'SP 0023900',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
