import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class DriverInformation extends StatelessWidget {
  final String head;
  const DriverInformation({
    required this.head,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: TSize.spaceBetweenSections),
        Text(
          head,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: TSize.spaceBetweenSections),

        CircleAvatar(
          radius: TSize.imageThumbSize,
          backgroundImage: AssetImage(TImage.hcBurger1),
        ),
        SizedBox(height: TSize.spaceBetweenItemsVertical),
        Text(
          'David Wayne',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary),
        ),
        Text(
          'Driver',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(height: TSize.spaceBetweenSections),
      ],
    );
  }
}
