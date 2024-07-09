import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/misc/icon_or_svg.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/order/views/contact/order_calling.dart';
import 'package:food_delivery_app/features/user/order/views/contact/order_message.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class OrderDriverInformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: "Driver Information",
      ),
      body: MainWrapper(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                CircleAvatar(
                  radius: TSize.imageThumbSize,
                  backgroundImage: AssetImage(TImage.hcBurger1),
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),
                Text(
                  'David Wayne',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: TColor.primary),
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text('4.9 ', style: Theme.of(context).textTheme.titleSmall),
                        SvgPicture.asset(
                          TIcon.fillStar
                        )
                      ],
                    ),
                    SizedBox(width: TSize.spaceBetweenItemsHorizontal * 3,),

                    Text('ID: DW9215', style: Theme.of(context).textTheme.titleSmall),
                  ],
                )
              ],
            ),
            SizedBox(height: TSize.spaceBetweenSections),
            SizedBox(height: TSize.spaceBetweenSections),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleIconCard(
                  onTap: () {
                    Get.to(() => OrderCallingView());
                  },
                  elevation: TSize.cardElevation,
                  icon: TIcon.call,
                  iconSize: TSize.iconLg,
                ),
                SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                CircleIconCard(
                  onTap: () {
                    Get.to(() => OrderMessageView());
                  },
                  elevation: TSize.cardElevation,
                  icon: TIcon.message,
                  iconSize: TSize.iconLg,
                ),
              ],
            ),
            SizedBox(height: TSize.spaceBetweenSections),
            SizedBox(height: TSize.spaceBetweenSections),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '(+44) 20 1234 5678',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(width: TSize.spaceBetweenItemsHorizontal,),

                IconOrSvg(icon: TIcon.call)
              ],
            )
          ],
        ),
      ),
    );
  }
}
