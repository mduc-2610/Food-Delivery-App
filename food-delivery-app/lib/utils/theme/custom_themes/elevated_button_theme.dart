import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: TColor.primary,
      disabledForegroundColor: Colors.white,
      disabledBackgroundColor: TColor.buttonDisabled,
      side: BorderSide(color: TColor.primary),
      padding: EdgeInsets.symmetric(vertical: 18),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    )
  );

  static ElevatedButtonThemeData darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: TColor.primary,
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: TColor.buttonDisabled,
          side: BorderSide(color: TColor.primary),
          padding: EdgeInsets.symmetric(vertical: 18),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      )
  );
}