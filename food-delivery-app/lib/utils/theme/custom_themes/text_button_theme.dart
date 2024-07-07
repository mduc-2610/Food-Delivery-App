import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';

class TTextButtonTheme {
  TTextButtonTheme._();

  static TextButtonThemeData lightTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      foregroundColor: TColor.primary,
      backgroundColor: Colors.transparent,
      side: BorderSide(width: 1, color: TColor.primary),
      disabledForegroundColor: Colors.grey,
      padding: EdgeInsets.symmetric(vertical: 18),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      disabledBackgroundColor: TColor.buttonDisabled,
    ),
  );

  static TextButtonThemeData darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      disabledForegroundColor: Colors.grey,
      padding: EdgeInsets.symmetric(vertical: 18),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      disabledBackgroundColor: TColor.buttonDisabled,
    ),
  );
}
