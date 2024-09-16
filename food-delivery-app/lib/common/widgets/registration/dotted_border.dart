import 'package:flutter/material.dart';

class DottedBorder extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final Widget child;

  const DottedBorder({
    Key? key,
    required this.color,
    required this.strokeWidth,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: strokeWidth, style: BorderStyle.solid),
      ),
      child: child,
    );
  }
}