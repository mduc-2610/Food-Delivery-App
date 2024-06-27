import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: BorderSide(color: Colors.blue),
      padding: EdgeInsets.symmetric(vertical: 18),
      textStyle: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)
    )
  );

  static ElevatedButtonThemeData darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: Colors.grey,
          side: BorderSide(color: Colors.blue),
          padding: EdgeInsets.symmetric(vertical: 18),
          textStyle: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)
      )
  );
}