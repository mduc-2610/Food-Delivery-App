import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final void Function(String) onChanged;
  final int maxLines;
  final int? maxLength;
  final TextEditingController? controller;

  RegistrationTextField({
    Key? key,
    required this.label,
    required this.onChanged,
    this.hintText = "Nhập",
    this.maxLines = 1,
    this.maxLength,
    this.controller,
  }) : super(key: key);

  @override
  State<RegistrationTextField> createState() => _RegistrationTextFieldState();
}

class _RegistrationTextFieldState extends State<RegistrationTextField> {
  int inputLength = 0;

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
          TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              counterText: (widget.maxLength != null) ? "${inputLength}/${widget.maxLength}" : "",
              border: OutlineInputBorder(),
              hintText: "${widget.hintText}",
            ),
            onChanged: (value) {
              // Update the input length
              setState(() {
                inputLength = value.length;
              });
              widget.onChanged(value);
            },
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
          ),
        ],
      ),
    );
  }
}
