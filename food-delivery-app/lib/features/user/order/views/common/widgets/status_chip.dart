import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class StatusChip extends StatelessWidget {
  final String? text;
  final String status;
  final VoidCallback? onTap;
  final double? paddingHorizontal;
  final double? paddingVertical;

  const StatusChip({
    Key? key,
    this.text,
    required this.status,
    this.onTap,
    this.paddingHorizontal,
    this.paddingVertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case 'ACTIVE':
        color = TColor.active;
        break;
      case 'COMPLETED':
        color = TColor.success;
        break;
      case 'CANCELLED':
        color = TColor.cancel;
        break;
      default:
        color = Colors.black;
    }
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical ?? TSize.xs,
          horizontal: paddingHorizontal ?? TSize.sm
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: color,
          ),
          borderRadius: BorderRadius.circular(TSize.lg),
        ),
        child: Text(text ?? status, style: TextStyle(color: color)),
      ),
    );
  }
}