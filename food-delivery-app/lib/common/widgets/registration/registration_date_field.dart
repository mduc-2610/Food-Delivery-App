import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationDateField extends StatefulWidget {
  final String label;
  final void Function(DateTime) onDateSelected;
  final String hintText;

  const RegistrationDateField({
    Key? key,
    required this.label,
    required this.onDateSelected,
    this.hintText = 'Select Date', // Default hint text
  }) : super(key: key);

  @override
  _RegistrationDateFieldState createState() => _RegistrationDateFieldState();
}

class _RegistrationDateFieldState extends State<RegistrationDateField> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "*${widget.label}",
            style: Get.textTheme.titleSmall?.copyWith(color: Colors.red),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: widget.hintText,
                  hintStyle: Get.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 12.0,
                  ),
                ),
                style: Get.textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
