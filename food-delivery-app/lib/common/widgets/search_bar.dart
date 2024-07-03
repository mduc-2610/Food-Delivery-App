import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';

class CSearchBar extends StatelessWidget {
  final String? hintText;
  const CSearchBar({
    this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(TIcon.search),
          suffixIcon: Icon(TIcon.filter)
      ),
    );
  }
}
