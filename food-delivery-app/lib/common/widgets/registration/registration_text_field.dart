import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/validators/validators.dart';
import 'package:get/get.dart';

class RegistrationTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final int maxLines;
  final int? maxLength;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  RegistrationTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.hintText = "Enter",
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<RegistrationTextField> createState() => _RegistrationTextFieldState();
}

class _RegistrationTextFieldState extends State<RegistrationTextField> {
  late int inputLength;
  String? Function(String?)? validator;

  @override
  void initState() {
    super.initState();
    validator = widget.validator ?? TValidator.validateTextField;
    inputLength = widget.controller.text.length;
    widget.controller.addListener(_updateInputLength);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateInputLength);
    super.dispose();
  }

  void _updateInputLength() {
    setState(() {
      inputLength = widget.controller.text.length;
    });
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
          TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              counterText: (widget.maxLength != null) ? "$inputLength/${widget.maxLength}" : "",
              border: OutlineInputBorder(),
              hintText: widget.hintText,
            ),
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            validator: validator,
            keyboardType: widget.keyboardType,
          ),
        ],
      ),
    );
  }
}
