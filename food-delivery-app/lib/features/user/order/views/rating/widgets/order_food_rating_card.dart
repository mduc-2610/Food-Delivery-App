import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_document_field.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/order/controllers/rating/order_rating_controller.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';


class OrderFoodRatingCard extends StatefulWidget {
  final Dish? dish;

  OrderFoodRatingCard({
    this.dish
  });

  @override
  State<OrderFoodRatingCard> createState() => _OrderFoodRatingCardState();
}

class _OrderFoodRatingCardState extends State<OrderFoodRatingCard> {
  int _rating = 0;
  final controller = OrderRatingController.instance;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(TSize.borderRadiusLg),
                    child: THelperFunction.getValidImage(
                      widget.dish?.image,
                      width: TSize.imageThumbSize,
                      height: TSize.imageThumbSize
                    )
                ),
                SizedBox(width: TSize.spaceBetweenItemsVertical),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.dish?.name}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsHorizontal,),
                      RatingBarIndicator(
                        itemPadding: EdgeInsets.only(right: TSize.spaceBetweenItemsHorizontal),
                        rating: THelperFunction.formatDouble(
                            controller.mapDishTextController[widget.dish]?["rating"]
                        ),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            controller.handleDishRating(index, widget.dish);
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
              controller: controller.mapDishTextController[widget.dish]["title"],
              decoration: InputDecoration(
                hintText: 'Type your title ...',
              ),
              maxLines: 1,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            TextField(
              controller: controller.mapDishTextController[widget.dish]["content"],
              decoration: InputDecoration(
                hintText: 'Type your review ...',
              ),
              maxLines: TSize.smMaxLines,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            RegistrationDocumentField(
              label: "Upload extra image",
              controller: controller.foodImagesController["${widget.dish?.id}"] ?? RegistrationDocumentFieldController(),
              viewEx: false,
              highlight: false,
            ),
          ],
        ),
      ),
    );
  }
}
