
import 'package:flutter/material.dart';

class TDatePickerTheme {
  TDatePickerTheme._();

  static DatePickerThemeData datePickerTheme = DatePickerThemeData(
    cancelButtonStyle: ButtonStyle(
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 0,
        )
      )
    ),
  );
}