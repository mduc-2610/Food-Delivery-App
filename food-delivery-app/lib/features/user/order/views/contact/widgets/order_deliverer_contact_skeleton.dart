import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class OrderDelivererContactSkeleton extends StatelessWidget {
  const OrderDelivererContactSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: "Deliverer Information",
      ),
      body: MainWrapper(
        child: Column(
          children: [
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            BoxSkeleton(
              height: TSize.avatarXl + 20,
              width: TSize.avatarXl + 20,
              // borderRadius: double.infinity,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            BoxSkeleton(
              height: 30,
              width: 200,
              // borderRadius: TSize.borderRadiusSm,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoxSkeleton(
                  height: 30,
                  width: 50,
                  // borderRadius: TSize.borderRadiusSm,
                ),
                SizedBox(width: TSize.spaceBetweenItemsHorizontal * 3),
                BoxSkeleton(
                  height: 30,
                  width: 100,
                  // borderRadius: TSize.borderRadiusSm,
                ),
              ],
            ),
            SizedBox(height: TSize.spaceBetweenSections),
            SizedBox(height: TSize.spaceBetweenSections),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoxSkeleton(
                  height: 70,
                  width: 70,
                  // borderRadius: double.infinity,
                ),
                SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                BoxSkeleton(
                  height: 70,
                  width: 70,
                  // borderRadius: double.infinity,
                ),
              ],
            ),
            SizedBox(height: TSize.spaceBetweenSections),
            SizedBox(height: TSize.spaceBetweenSections),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoxSkeleton(
                  height: 30,
                  width: 150,
                  // borderRadius: TSize.borderRadiusSm,
                ),
                SizedBox(width: TSize.spaceBetweenItemsHorizontal),
                BoxSkeleton(
                  height: TSize.iconMd,
                  width: TSize.iconMd,
                  // borderRadius: double.infinity,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
