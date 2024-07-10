import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';


class FoodCardLs extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;
  final String rating;
  final String reviewCount;
  final String tag;

  const FoodCardLs({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(TSize.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSize.borderRadiusLg),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(TSize.borderRadiusMd),
              child: Image.asset(
                imageUrl,
                width: TSize.imageThumbSize,
                height: TSize.imageThumbSize,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: TSize.spaceBetweenItemsHorizontal),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsSm),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(TSize.borderRadiusSm),
                    ),
                    child: Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TColor.star),
                    ),
                  ),
                  SizedBox(height: TSize.spaceBetweenItemsSm),
                  Row(
                    children: [
                      SvgPicture.asset(
                          TIcon.fillStar
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsSm),
                      Text(
                        rating,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.star),
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsSm),
                      Text(
                        "($reviewCount reviews)",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleIconCard(
                  onTap: () {
                  },
                  elevation: TSize.iconCardElevation,
                  icon: Icons.more_horiz,
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical,),

                Text(
                  "£$price",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}