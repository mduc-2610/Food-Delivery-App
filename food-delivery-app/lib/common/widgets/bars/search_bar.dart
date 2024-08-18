import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';

class CSearchBar extends StatelessWidget {
  final String? hintText;
  final controller;
  final VoidCallback? prefixPressed;
  final VoidCallback? suffixPressed;

  const CSearchBar({
    this.hintText,
    this.controller,
    this.prefixPressed,
    this.suffixPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: InkWell(
            onTap: prefixPressed,
            child: Icon(TIcon.search)
          ),
          suffixIcon: InkWell(
            onTap: suffixPressed,
            child: Icon(TIcon.filter)
          )
      ),
    );
  }
}
