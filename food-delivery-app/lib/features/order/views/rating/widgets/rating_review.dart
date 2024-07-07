import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';


class RatingReview extends StatefulWidget {

  const RatingReview({super.key});

  @override
  State<RatingReview> createState() => _RatingReviewState();
}

class _RatingReviewState extends State<RatingReview> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            maxLines: TSize.lgMaxLines,
          ),
        ],
      ],
    );
  }
}
