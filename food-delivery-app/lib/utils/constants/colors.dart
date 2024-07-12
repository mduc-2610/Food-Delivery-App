import 'package:flutter/material.dart';

class TColor {
  TColor._();

  // App Basic Colors
  // static const Color primary = Color(0xffff6347);
  static const Color primary = Colors.green;
  static const Color secondary = Color(0xFF4b68ff);
  static const Color accent = Color(0xFF4b68ff);

  static const Color star = Colors.amber;

  // Text Colors
  static const Color textPrimary = Color(0xFF4b68ff);
  static const Color textSecondary = Color(0xFF4b68ff);
  static const Color textDesc = Color(0xFF7f7e7c);

  // Background Colors
  static const Color light = Color(0xffffffff);
  static const Color dark = Color(0xff000000);
  static const Color primaryBackground = Color(0xFF4b68ff);

  // Input Background Colors
  static const Color inputLightBackgroundColor = Color(0xFFf4f4f5);
  static const Color inputDarkBackgroundColor = Color(0xFF25292e);

  // Input Text Colors
  static const Color inputLightTextColor = Color(0xFF0d1217);
  static const Color inputDarkTextColor = Color(0xFFe9eaeb);

  // Input hintTextColors
  static const Color inputLightHintTextColor = Color(0xFFafb0b3);
  static const Color inputDarkHintTextColor = Color(0xFF52565a);

  // Input Border Colors
  static const Color inputLightBorderColor = Color(0xFFe9eaeb);
  static const Color inputDarkBorderColor = Color(0xFF4c555f);

  // Input Focus Border Colors
  static const Color inputFocusBorderColor = Color(0xFFbabdc1);

  // Background Container Colors
  static const Color lightContainer = Color(0xFF4b68ff);
  static const Color darkContainer = Color(0xFF4b68ff);

  // Button Colors
  static const Color buttonPrimary = Color(0xffff6347);
  static const Color buttonSecondary = Color(0xFF4b68ff);
  static const Color buttonDisabled = Color(0xFFffcfc6);

  // Border Colors
  static const Color borderPrimary = Color(0xFFe9eaeb);
  static const Color borderSecondary = Color(0xFF4b68ff);

  // Error and Validation Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF13c296);
  static const Color info = Color(0xFF1976D2);
  static const Color warning = Color(0xFFFFA000);
  static const Color disable = Color(0xFFb7b8ba);
  static const Color active = Color(0xFFff6347);
  static const Color cancel = Color(0xFF7f7e7c);

  // Icon Bg Color
  static const Color iconBgSuccess = Color(0xFFe7f9f5);
  static const Color iconBgInfo = Color(0xFFfff9e6);
  static const Color iconBgCancel = Color(0xFFffefed);
  static const Color iconColor = Color(0xFFb7b8ba);

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