import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/field_skeleton_list.dart';

class PersonalSettingSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          FieldSkeletonList(length: 10)
        ]
    );
  }
}