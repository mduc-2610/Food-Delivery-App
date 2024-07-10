import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class FoodCardGr extends StatelessWidget {
  final String image;
  final double? imageWidth, imageHeight;
  final BoxFit fit;
  final String name;
  final double stars;
  final double originalPrice;
  final double salePrice;
  final VoidCallback onTap;
  final String? heart;

  const FoodCardGr({
    required this.name,
    required this.image,
    this.imageWidth,
    this.imageHeight,
    this.fit = BoxFit.cover,
    required this.stars,
    required this.originalPrice,
    required this.salePrice,
    required this.onTap,
    this.heart,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: TSize.cardElevation,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(TSize.sm + 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(TSize.sm),
                    child: Image.asset(
                      image,
                      width: imageWidth,
                      height: imageHeight,
                      fit: fit,
                    ),
                  ),
                  Positioned(
                    top: TSize.sm,
                    right: TSize.sm,
                    child: Container(
                      padding: EdgeInsets.all(TSize.sm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(TSize.borderRadiusCircle)
                      ),
                      child: SvgPicture.asset(
                        heart ?? TIcon.heart ,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: TSize.xs,),

              Text(name, style: Theme.of(context).textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis,),
              SizedBox(height: TSize.xs,),

              Row(
                children: [
                  SvgPicture.asset(
                    TIcon.fillStar
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "$stars",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "£$originalPrice",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                  Text(
                    "£$salePrice",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );;
  }
}
