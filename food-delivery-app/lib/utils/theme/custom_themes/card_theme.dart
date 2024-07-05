import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class TCardTheme {
  TCardTheme._();

  static CardTheme lightCardTheme = CardTheme(
    shadowColor: TColor.dark,
    surfaceTintColor: TColor.light,
    elevation: TSize.cardElevation,
  );

  static CardTheme darkCardTheme = CardTheme(
    shadowColor: TColor.light.withOpacity(0.3),
    surfaceTintColor: TColor.dark,
    elevation: TSize.cardElevation
  );
}