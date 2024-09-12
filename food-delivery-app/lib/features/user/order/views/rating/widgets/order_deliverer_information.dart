import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class OrderDelivererInformation extends StatelessWidget {
  final String? head;
  final Deliverer? deliverer;

  const OrderDelivererInformation({
    this.head,
    this.deliverer,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${head ?? ""}",
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
          '${deliverer?.basicInfo?.givenName} ${deliverer?.basicInfo?.fullName}',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary),
        ),
        Text(
          'Deliverer',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
