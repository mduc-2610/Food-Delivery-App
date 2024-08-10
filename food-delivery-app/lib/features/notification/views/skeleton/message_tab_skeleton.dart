import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class MessageTabSkeleton extends StatelessWidget {
  final int length;

  MessageTabSkeleton({
    this.length = 10,
  });

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      child: ListView(
        children: [
          BoxSkeleton(height: 60, width: 40, borderRadius: 20),
          SizedBox(height: TSize.spaceBetweenItemsVertical),
          for (int i = 0; i < length; i++)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: BoxSkeleton(
                width: TSize.imageMd,
                height: TSize.imageMd,
                borderRadius: TSize.borderRadiusLg,
              ),
              title: BoxSkeleton(height: 16, width: 10),
              subtitle: BoxSkeleton(height: 14, width: 70),
              trailing: BoxSkeleton(height: 20, width: 20, borderRadius: 10),
            ),
        ],
      ),
    );
  }
}