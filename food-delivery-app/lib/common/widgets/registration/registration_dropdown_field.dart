import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/validators/validators.dart';
import 'package:get/get.dart';

class RegistrationDropdownField extends StatelessWidget {
  final String label;
  final List<String> items;
  final void Function(String?) onChanged;
  final String hintText;
  final String? value;

  const RegistrationDropdownField({
    Key? key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.hintText = 'Choose',
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "*$label",
            style: Get.textTheme.titleSmall?.copyWith(color: Colors.red),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            hint: Text(
              hintText,
              style: Get.textTheme.titleMedium?.copyWith(color: TColor.disable),
            ),
            items: items
                .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, maxLines: 1, overflow: TextOverflow.ellipsis,),
            ))
                .toList(),
            value: (items.contains(value)) ? value : null, // Ensure value is valid
            onChanged: onChanged,
            validator: TValidator.validateTextField,
          ),
        ],
      ),
    );
  }
}
