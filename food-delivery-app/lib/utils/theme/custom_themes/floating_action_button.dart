import 'package:flutter/material.dart';

class TFloatingActionButton {
  TFloatingActionButton._();

  static FloatingActionButtonThemeData lightFloatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: Colors.black.withOpacity(0.2),
    elevation: 1
  );

  static FloatingActionButtonThemeData darkFloatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: Colors.white.withOpacity(0.5),
    elevation: 1
  );
}