import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/rating_bar.dart';


class FoodDetailReviewRatingDistribution extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 5; i >= 1; i--)...[
          CRatingBar(prefixText: i.toString() ,value: i / 5),
        ]
      ],
    );
  }
}