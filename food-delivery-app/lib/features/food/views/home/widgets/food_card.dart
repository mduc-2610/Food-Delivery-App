import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class FoodCard extends StatelessWidget {
  final String image;
  final String name;
  final double stars;
  final double originalPrice;
  final double salePrice;
  final VoidCallback onTap;

  const FoodCard({
    required this.name,
    required this.image,
    required this.stars,
    required this.originalPrice,
    required this.salePrice,
    required this.onTap,
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
                        TIcon.heart,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: TSize.xs,),

              Text(name, style: Theme.of(context).textTheme.bodyMedium),
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
                  Stack(
                    children: [
                      Text(
                        "£$originalPrice",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Positioned(
                        bottom: 2,
                        child: SizedBox(
                          width: 100,
                          child: Divider(
                            thickness: 2,
                            color: Theme.of(context).textTheme.bodySmall?.color
                          )
                        )
                      )
                    ],
                  ),
                  SizedBox(width: 10,),

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
