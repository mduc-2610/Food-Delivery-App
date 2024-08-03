import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:shimmer/shimmer.dart';

class FieldSkeleton extends StatelessWidget {

  const FieldSkeleton({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return
      Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: BoxSkeleton(height: 60, width: double.infinity, borderRadius: 10)
      );
  }
}

