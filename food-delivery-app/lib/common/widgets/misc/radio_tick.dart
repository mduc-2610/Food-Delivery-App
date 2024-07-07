import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';

class RadioTick extends StatelessWidget {
  final int value;
  final int groupValue;
  final ValueChanged<int> onChanged;

  RadioTick({
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? TColor.primary : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? TColor.primary : TColor.borderPrimary,
            width: 2,
          ),
        ),
        child: isSelected
            ? Icon(
          TIcon.check,
          color: TColor.light,
          size: 20,
        )
            : Container(
          width: 20.0,
          height: 20.0,
        ),
      ),
    );
  }
}