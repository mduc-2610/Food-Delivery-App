import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/misc/list_check.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/misc/sliver_sized_box.dart';
import 'package:food_delivery_app/features/user/food/models/review/review.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class DetailReviewList extends StatelessWidget {
  final String filter;
  final dynamic controller;

  const DetailReviewList({
    Key? key,
    required this.filter,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print("Building DetailReviewList with ${controller.reviews.length} reviews");
      return CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                if (index >= controller.reviews.length) {
                  controller.loadMoreReviews(filter: filter);
                  return SizedBox();
                }
                final review = controller.reviews[index];
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(TSize.borderRadiusCircle),
                              child: Image.asset(
                                TImage.hcBurger1,
                                width: TSize.imageSm,
                                height: TSize.imageSm,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${review.user?.name ?? ""}"),
                                Text("${THelperFunction.formatDate(review.createdAt ?? DateTime.now())}"),
                              ],
                            )
                          ],
                        ),
                        RatingBarIndicator(
                          rating: (review.rating ?? 0).toDouble(),
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
                        Text(
                            "${review.content ?? ""}"
                        ),
                      ],
                    ),
                    SizedBox(height: TSize.spaceBetweenItemsVertical),

                    // Like button and total likes section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.toggleLike(review);
                          },
                          child: Row(
                            children: [
                              Icon(
                                review.isLiked.value ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                                color: review.isLiked.value ? Colors.blue : Colors.grey,
                              ),
                              SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                              Text("${review.totalLikes.value}"),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: TSize.spaceBetweenSections),
                  ],
                );
              },
              childCount: controller.reviews.length + 1, // +1 for loading indicator
            ),
          ),
          SliverSizedBox(height: TSize.spaceBetweenSections,),
          SliverSizedBox(height: TSize.spaceBetweenItemsVertical,),
        ],
      );
    });
  }
}
