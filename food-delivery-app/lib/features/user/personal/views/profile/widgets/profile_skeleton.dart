import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/common/widgets/skeleton/circle_box_skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';


class ProfileSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey.shade300,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoxSkeleton(
              width: 100,
              height: 20,
            ),
            SizedBox(height: 8),
            BoxSkeleton(
              width: 150,
              height: 16,
            ),
            SizedBox(height: 8),
            BoxSkeleton(
              width: 180,
              height: 16,
            ),
          ],
        ),
        trailing: CircleBoxSkeleton(height: 45, width: 45),
      ),
    );
  }
}