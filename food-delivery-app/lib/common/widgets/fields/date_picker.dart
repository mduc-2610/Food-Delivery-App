import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final xcontroller;
  final String labelText;
  final String hintText;
  final String datePattern;
  final String? Function(String?)? validator;

  const CDatePicker({
    required this.controller,
    this.xcontroller,
    required this.labelText,
    this.hintText = "",
    this.datePattern = 'MM/yy',
    this.validator,
    super.key
  });

  @override
  State<CDatePicker> createState() => _CDatePickerState();
}

class _CDatePickerState extends State<CDatePicker> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.xcontroller.selectedDate);
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.calendar_today),
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
          setState(() {
            widget.xcontroller.selectedDate = pickedDate;
            _controller.text = formattedDate;
          });
        }
      },
      validator: widget.validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter expiry date';
        }
        return null;
      },
    );
  }
}
