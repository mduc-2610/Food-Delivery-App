import 'package:flutter/material.dart';

class TFloatingActionButton {
  TFloatingActionButton._();

  static FloatingActionButtonThemeData lightFloatingActionButton = FloatingActionButtonThemeData(
    backgroundColor: Colors.black.withOpacity(0.2),
    elevation: 1
  );

  static FloatingActionButtonThemeData darkFloatingActionButton = FloatingActionButtonThemeData(
    backgroundColor: Colors.white.withOpacity(0.5),
    elevation: 1
  );
}