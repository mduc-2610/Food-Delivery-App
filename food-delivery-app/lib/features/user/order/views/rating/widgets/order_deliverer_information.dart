import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/user/order/views/contact/order_deliverer_contact.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

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
    return InkWell(
      onTap: () {
        Get.to(() => OrderDelivererContactView(), arguments: {
          "id": deliverer?.id
        });
      },
      child: Column(
        children: [
          Text(
            "${head ?? ""}",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: TSize.spaceBetweenSections),

          THelperFunction.getValidImage(
            deliverer?.avatar,
            width: TSize.avatarXl,
            height: TSize.avatarXl,
            radius: double.infinity,
          ),
          // CircleAvatar(
          //   radius: TSize.imageThumbSize,
          //   backgroundImage: ,
          // ),
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
      ),
    );
  }
}
