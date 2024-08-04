import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:shimmer/shimmer.dart';

class ListFieldSkeleton extends StatelessWidget {
  final int length;

  const ListFieldSkeleton({
    required this.length,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          for(int i = 0; i < length; i++)...[
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: BoxSkeleton(height: 60, width: double.infinity),
            ),
            if(i != length - 1) SizedBox(height: TSize.spaceBetweenInputFields,),
          ]
        ],
      );
  }
}