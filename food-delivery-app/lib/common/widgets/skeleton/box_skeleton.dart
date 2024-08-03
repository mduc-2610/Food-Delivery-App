import 'package:flutter/material.dart';


class BoxSkeleton extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const BoxSkeleton({
    required this.height,
    required this.width,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}