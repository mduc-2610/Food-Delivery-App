import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String datePattern;
  final String? Function(String?)? validator;
  final Function(DateTime?)? onDateSelected;  // Add this line

  const CDatePicker({
    required this.controller,
    required this.labelText,
    this.hintText = "",
    this.datePattern = 'MM/yy',
    this.validator,
    this.onDateSelected,  // Add this line
    Key? key,
  }) : super(key: key);

  @override
  State<CDatePicker> createState() => _CDatePickerState();
}

class _CDatePickerState extends State<CDatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat(widget.datePattern).format(pickedDate);
          widget.controller.text = formattedDate;
          widget.onDateSelected?.call(pickedDate);  // Add this line
        } else {
          widget.onDateSelected?.call(null);  // Add this line to handle date clearing
        }
      },
      validator: widget.validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a date';
        }
        return null;
      },
    );
  }
}