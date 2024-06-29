import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';

class TInputDecorationTheme {
  TInputDecorationTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: TColor.inputLightHintTextColor,
    suffixIconColor: TColor.inputLightHintTextColor,

    labelStyle: const TextStyle().copyWith(fontSize: 14, color: TColor.inputLightHintTextColor),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: TColor.inputLightHintTextColor),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: TColor.inputLightBorderColor)
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: TColor.inputLightBorderColor)
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: TColor.inputFocusBorderColor)
    ),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.red)
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.orange)
    ),
    filled: true,
    fillColor: TColor.inputLightBackgroundColor
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: TColor.inputDarkHintTextColor,
    suffixIconColor: TColor.inputDarkHintTextColor,

    labelStyle: const TextStyle().copyWith(fontSize: 14, color: TColor.inputDarkHintTextColor),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: TColor.inputDarkHintTextColor),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: TColor.inputDarkBorderColor)
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: TColor.inputDarkBorderColor)
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: TColor.inputFocusBorderColor)
    ),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.red)
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(width: 1, color: Colors.orange)
    ),
    filled: true,
    fillColor: TColor.inputDarkBackgroundColor
  );
}