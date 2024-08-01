import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/bars/separate_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/round_icon_button.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/icon_or_svg.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

enum FoodCardType { grid, list }

class FoodCard extends StatelessWidget {
  final FoodCardType type;
  final String image;
  final String name;
  final double stars;
  final double originalPrice;
  final double salePrice;
  final VoidCallback onTap;
  final String? heart;
  final double? imageWidth;
  final double? imageHeight;
  final BoxFit fit;
  final String? reviewCount;
  final String? tag;

  const FoodCard({
    required this.type,
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
    this.reviewCount,
    this.tag,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (type == FoodCardType.grid) {
      return _buildGridCard(context);
    } else {
      return _buildListCard(context);
    }
  }

  Widget _buildGridCard(BuildContext context) {
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
                        borderRadius: BorderRadius.circular(TSize.borderRadiusCircle),
                      ),
                      child: SvgPicture.asset(
                        heart ?? TIcon.heart,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: TSize.xs),
              Text(
                name,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: TSize.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(TIcon.fillStar),
                  SizedBox(width: TSize.spaceBetweenItemsSm),
                  Text(
                    "$stars",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.star),
                  ),
                  SizedBox(width: TSize.spaceBetweenItemsSm),
                  SeparateBar(),
                  SizedBox(width: TSize.spaceBetweenItemsSm),
                  Icon(
                    Icons.thumb_up,
                    size: TSize.iconSm,
                    color: TColor.primary,
                  ),
                  SizedBox(width: TSize.spaceBetweenItemsSm),
                  Text(
                    reviewCount ?? "5.3k",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "£$originalPrice",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                  Text(
                    "£$salePrice",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                  ),
                  Spacer(),
                  RoundIconButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: TDeviceUtil.getScreenWidth(),
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSize.borderRadiusLg),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(TSize.borderRadiusMd),
                  child: Image.asset(
                    image,
                    width: TSize.imageThumbSize + 30,
                    height: TSize.imageThumbSize + 30,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: TSize.spaceBetweenItemsHorizontal),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      // SizedBox(height: TSize.spaceBetweenItemsSm),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(TIcon.fillStar),
                          SizedBox(width: TSize.spaceBetweenItemsSm),
                          Text(
                            "$stars",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.star),
                          ),
                          SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                          SeparateBar(),
                          SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                          Icon(
                            Icons.thumb_up,
                            size: TSize.iconSm,
                            color: TColor.primary,
                          ),
                          SizedBox(width: TSize.spaceBetweenItemsSm),
                          Text(
                            reviewCount ?? "5.3k",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: TSize.spaceBetweenItemsSm),

                      Row(
                        children: [
                          Text(
                            "£$originalPrice",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: TColor.textDesc,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 2,
                                decorationColor: TColor.textDesc
                            ),
                          ),

                        ],
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${salePrice}00d",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: TColor.primary),
                          ),
                          Spacer(),

                          IconOrSvg(
                            iconStr: heart ?? TIcon.heart,
                            size: TSize.iconSm,
                          ),
                          SizedBox(width: TSize.spaceBetweenItemsLg),

                          RoundIconButton()
                        ],
                      )

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
