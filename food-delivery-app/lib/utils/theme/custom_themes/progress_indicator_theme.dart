import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';

class TProgressIndicator {
  TProgressIndicator._();

  static final progressIndicatorTheme = ProgressIndicatorThemeData(
    color: TColor.primary.withOpacity(0.5),
    linearTrackColor: TColor.light
  );
}