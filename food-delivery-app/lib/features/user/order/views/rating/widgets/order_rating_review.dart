import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_document_field.dart';
import 'package:food_delivery_app/features/user/order/controllers/rating/order_rating_controller.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';


class RatingReview extends StatefulWidget {
  const RatingReview({super.key});

  @override
  State<RatingReview> createState() => _RatingReviewState();
}

class _RatingReviewState extends State<RatingReview> {
  @override
  Widget build(BuildContext context) {
    final _controller = OrderRatingController.instance;
    return Column(
      children: [
        Obx(() => RatingBarIndicator(
          itemPadding: EdgeInsets.only(right: TSize.spaceBetweenItemsHorizontal),
          rating: _controller.ratingList[_controller.currentTab].toDouble(),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              _controller.handleRating(index);
            },
            child: SvgPicture.asset(
              TIcon.fillStar,
            ),
          ),
          itemCount: 5,
          itemSize: 65,
        )),
        SizedBox(height: TSize.spaceBetweenSections),
        if(_controller.currentTab != 0)...[
          TextField(
            controller: (_controller.currentTab == 1)
                ? _controller.delivererTitleTextController
                : _controller.restaurantTitleTextController,
            decoration: InputDecoration(
                hintText: 'Type your title (Option)...',
                hintStyle: TextStyle(
                )
            ),
            maxLines: 1,
          ),
          SizedBox(height: TSize.spaceBetweenItemsSm),
          TextField(
            controller: (_controller.currentTab == 1)
                ? _controller.delivererContentTextController
                : _controller.restaurantContentTextController,
            decoration: InputDecoration(
                hintText: 'Type your review (Option)...',
                hintStyle: TextStyle(
                )
            ),
            maxLines: TSize.lgMaxLines,
          ),
        ],
        if(_controller.tabController.index == 2)...[
          SizedBox(height: TSize.spaceBetweenItemsVertical),
          RegistrationDocumentField(
            label: "Upload extra image",
            controller: _controller.restaurantImagesController,
            viewEx: false,
            highlight: false,
          ),
        ]
      ],
    );
  }
}
