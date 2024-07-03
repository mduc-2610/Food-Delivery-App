import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/main_button.dart';
import 'package:food_delivery_app/common/widgets/main_wrapper.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';


class FoodDetailBottomAppBar extends StatelessWidget {
  const FoodDetailBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TDeviceUtil.getBottomNavigationBarHeight() * 2,
      child: BottomAppBar(
        surfaceTintColor: Colors.white,
        child: Container(
          margin: EdgeInsets.only(bottom: TDeviceUtil.getAppBarHeight() * 0.05),
          child: Card(
            elevation: 9,
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      CircleIconCard(
                        icon: Icons.remove,
                        iconColor: TColor.primary,
                        borderSideWidth: 1,
                        borderSideColor: TColor.primary,
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsVertical,),

                      Text(
                        '1',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsVertical,),

                      CircleIconCard(
                        icon: Icons.add,
                        iconColor: TColor.primary,
                        borderSideWidth: 1,
                        borderSideColor: TColor.primary,
                      ),
                    ],
                  ),
                  MainButton(
                    paddingHorizontal: TSize.xl,
                    onPressed: () {},
                    text: "Add to Basket",
                    prefixIconStr: TIcon.fillCart,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}