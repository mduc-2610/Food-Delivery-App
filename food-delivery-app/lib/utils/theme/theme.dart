import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/theme/custom_themes/appbar_theme.dart';
import 'package:food_delivery_app/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:food_delivery_app/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:food_delivery_app/utils/theme/custom_themes/chip_theme.dart';
import 'package:food_delivery_app/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:food_delivery_app/utils/theme/custom_themes/floating_action_button.dart';
import 'package:food_delivery_app/utils/theme/custom_themes/switch_theme.dart';
import 'package:food_delivery_app/utils/theme/custom_themes/text_button_theme.dart';
import 'package:food_delivery_app/utils/theme/custom_themes/input_decoration_theme.dart';
import 'package:food_delivery_app/utils/theme/custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    textButtonTheme: TTextButtonTheme.lightTextButtonTheme,
    inputDecorationTheme: TInputDecorationTheme.lightInputDecorationTheme,
    floatingActionButtonTheme: TFloatingActionButton.lightFloatingActionButton,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: TColor.primary,
    ),
    switchTheme: TSwitchTheme.switchTheme
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    textButtonTheme: TTextButtonTheme.darkTextButtonTheme,
    inputDecorationTheme: TInputDecorationTheme.darkInputDecorationTheme,
    floatingActionButtonTheme: TFloatingActionButton.darkFloatingActionButton,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: TColor.primary,
    ),
    switchTheme: TSwitchTheme.switchTheme

  );
}