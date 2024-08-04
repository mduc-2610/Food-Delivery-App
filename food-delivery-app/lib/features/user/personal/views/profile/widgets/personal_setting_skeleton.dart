import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/list_field_skeleton.dart';

class PersonalSettingSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ListFieldSkeleton(length: 10)
        ]
    );
  }
}