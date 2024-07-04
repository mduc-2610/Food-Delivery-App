import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';

class TSwitchTheme {
  TSwitchTheme._();

  static final switchTheme = SwitchThemeData(
    thumbColor: MaterialStateProperty.all(
      TColor.light
    ),
    trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return TColor.primary;
      }
      return TColor.textDesc;
    }),
    trackOutlineColor: MaterialStateProperty.all(
      Colors.transparent
    )
  );
}
