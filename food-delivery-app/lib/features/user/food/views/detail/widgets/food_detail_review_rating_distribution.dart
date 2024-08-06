import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/rating_bar.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class FoodDetailReviewRatingDistribution extends StatelessWidget {
  final Dish? dish;

  const FoodDetailReviewRatingDistribution({
    this.dish,
  });

  @override
  Widget build(BuildContext context) {
    final int totalReviews = dish?.totalReviews ?? 1;
    final Map<String, dynamic> ratingCounts = dish?.ratingCounts ?? {};

    return Column(
      children: [
        for (int i = 5; i >= 1; i--)...[
          CRatingBar(
            prefixText: "(${THelperFunction.formatNumber(ratingCounts[i.toString()])}) ${i.toString()}",
            value: (ratingCounts[i.toString()] ?? 0) / totalReviews,
          ),
        ]
      ],
    );
  }
}
