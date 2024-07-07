import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';


class MealRatingCard extends StatefulWidget {
  final String mealName;
  final String imageUrl;
  final int rating;
  final String? review;

  MealRatingCard({
    required this.mealName,
    required this.imageUrl,
    required this.rating,
    this.review,
  });

  @override
  State<MealRatingCard> createState() => _MealRatingCardState();
}

class _MealRatingCardState extends State<MealRatingCard> {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(TSize.borderRadiusLg),
                    child: Image.asset(widget.imageUrl, fit: BoxFit.cover, width: TSize.imageThumbSize, height: TSize.imageThumbSize)
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
                              if(_rating == index + 1) _rating = 0;
                              else _rating = index + 1;
                            });
                          },
                          child: SvgPicture.asset(
                            TIcon.fillStar,
                          ),
                        ),
                        itemCount: 5,
                        itemSize: TSize.iconXl,
                      ),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),

            TextField(
              decoration: InputDecoration(
                hintText: 'Type your review ...',
              ),
              maxLines: TSize.smMaxLines,
            ),
          ],
        ),
      ),
    );
  }
}
