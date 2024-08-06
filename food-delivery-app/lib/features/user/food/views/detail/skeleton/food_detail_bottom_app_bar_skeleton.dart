import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';


class FoodDetailBottomAppBarSkeleton extends StatelessWidget {
  const FoodDetailBottomAppBarSkeleton({Key? key}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      BoxSkeleton(
                        height: 40,
                        width: 40,
                        borderRadius: 20,
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsVertical),
                      BoxSkeleton(
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(width: TSize.spaceBetweenItemsVertical),
                      BoxSkeleton(
                        height: 40,
                        width: 40,
                        borderRadius: 20,
                      ),
                    ],
                  ),
                  Spacer(),
                  BoxSkeleton(
                    height: 60,
                    width: 150,
                    borderRadius: TSize.borderRadiusCircle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}