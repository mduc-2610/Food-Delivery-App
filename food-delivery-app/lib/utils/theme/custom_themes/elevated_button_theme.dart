import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return TColor.buttonDisabled;
        }
        return TColor.primary;
      }),
      side: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return BorderSide(color: TColor.buttonDisabled);
        }
        return BorderSide(color: TColor.primary);
      }),
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 18)),
      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    ),
  );

  static ElevatedButtonThemeData darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return TColor.buttonDisabled;
        }
        return TColor.primary;
      }),
      side: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return BorderSide(color: TColor.buttonDisabled);
        }
        return BorderSide(color: TColor.primary);
      }),
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 18)),
      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    ),
  );
}
