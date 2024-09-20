import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/fields/date_picker.dart';
import 'package:food_delivery_app/utils/validators/validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegistrationDateField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final DateTime? selectedDate;
  final dynamic Function(DateTime?) onDateSelected;
  final String hintText;
  final String? Function(String?)? validator;

  const RegistrationDateField({
    Key? key,
    this.controller,
    required this.label,
    required this.onDateSelected,
    this.selectedDate,
    this.hintText = 'Select Date',
    this.validator,
  }) : super(key: key);

  @override
  _RegistrationDateFieldState createState() => _RegistrationDateFieldState();
}

class _RegistrationDateFieldState extends State<RegistrationDateField> {
  DateTime ? selectedDate;


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ?? DateTime.now(),
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
    final controller = widget.controller ?? TextEditingController();
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
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
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
              String formattedDate = DateFormat("dd/MM/yyyy").format(pickedDate);
              controller.text = formattedDate;
              widget.onDateSelected.call(pickedDate);
            } else {
              widget.onDateSelected.call(null);
            }
          },
          validator: widget.validator ?? TValidator.validateTextField
          ),
        ],
      ),
    );
  }
}
