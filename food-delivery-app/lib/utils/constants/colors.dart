import 'package:flutter/material.dart';

class TColor {
  TColor._();

  // App Basic Colors
  static const Color primary = Color(0xffff6347);
  static const Color secondary = Color(0xFF4b68ff);
  static const Color accent = Color(0xFF4b68ff);

  // Text Colors
  static const Color textPrimary = Color(0xFF4b68ff);
  static const Color textSecondary = Color(0xFF4b68ff);
  static const Color textWhite = Color(0xFF4b68ff);

  // Background Colors
  static const Color light = Color(0xFF4b68ff);
  static const Color dark = Color(0xFF4b68ff);
  static const Color primaryBackground = Color(0xFF4b68ff);

  // Background Container Colors
  static const Color lightContainer = Color(0xFF4b68ff);
  static const Color darkContainer = Color(0xFF4b68ff);

  // Button Colors
  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF4b68ff);
  static const Color buttonDisabled = Color(0xFF4b68ff);

  // Border Colors
  static const Color borderPrimary = Color(0xFF4b68ff);
  static const Color borderSecondary = Color(0xFF4b68ff);

  // Error and Validation Colors
  static const Color error = Color(0xFF4b68ff);
  static const Color success = Color(0xFF4b68ff);
  static const Color warning = Color(0xFF4b68ff);
  static const Color info = Color(0xFF4b68ff);

  //Neutral Shades
  static const Color black = Color(0xFF4b68ff);
  static const Color darkerGrey = Color(0xFF4b68ff);
  static const Color c = Color(0xFF4b68ff);
  static const Color x = Color(0xFF4b68ff);

  //Gradient
  static  Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors:[
      Color(0xffff9a9e),
      Color(0xffff9a9e),
      Color(0xffff9a9e),
    ]
  );
}