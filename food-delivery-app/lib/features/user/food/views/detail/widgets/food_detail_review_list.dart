import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';


class FoodDetailReviewList extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;
  final String filter;

  const FoodDetailReviewList({
    Key? key,
    required this.reviews,
    required this.filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredReviews = filter == 'All'
        ? reviews
        : reviews.where((review) {
      if (filter == 'Positive') {
        return review['type'] == 'positive';
      } else if (filter == 'Negative') {
        return review['type'] == 'negative';
      } else {
        return review['rating'].toString() == filter;
      }
    }).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredReviews.length,
      itemBuilder: (context, index) {
        final review = filteredReviews[index];
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150'),
                    ),
                    SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(review['name']),
                        Text(review['date']),
                      ],
                    )
                  ],
                ),

                RatingBarIndicator(
                  rating: review['rating'].toDouble(),
                  itemBuilder: (context, index) => SvgPicture.asset(
                    TIcon.fillStar,
                  ),
                  itemCount: 5,
                  itemSize: TSize.iconSm,
                ),
              ],
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review['review']),
              ],
            ),
            SizedBox(height: TSize.spaceBetweenSections),

          ],
        );
      },
    );
  }
}