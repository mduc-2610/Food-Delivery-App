import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RegistrationTypeOption extends StatelessWidget {
  final String label;
  final List<String> types;
  final String selectedType;
  final ValueChanged<String> onChanged;

  const RegistrationTypeOption({
    Key? key,
    required this.label,
    required this.types,
    required this.selectedType,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "*${label}",
        style: Get.textTheme.titleSmall?.copyWith(color: Colors.red),
      ),
      SizedBox(height: 4),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: types
            .map((type) => Expanded(
          child: Row(
            children: [
              if (type != types[0]) SizedBox(width: TSize.spaceBetweenItemsHorizontal,),
              Expanded(
                child: TypeOption(
                  type: type,
                  isSelected: selectedType == type,
                  onTap: () => onChanged(type),
                ),
              ),
            ],
          ),
        ))
            .toList(),
      ),
    ],
        );
  }
}

class TypeOption extends StatelessWidget {
  final String type;
  final bool isSelected;
  final VoidCallback onTap;

  const TypeOption({
    Key? key,
    required this.type,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // margin: EdgeInsets.only(left: 8),
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.pink[50] : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.pink : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? Colors.pink : Colors.grey,
              size: 20,
            ),
            SizedBox(width: 4),
            Text(
              type,
              style: TextStyle(
                color: isSelected ? Colors.pink : Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}