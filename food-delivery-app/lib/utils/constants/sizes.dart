import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';

class TSize {
  TSize._();

  // Padding and margin sizes
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  // Position center horizontal
  static double getPosCenterHorizontal() {
    return TDeviceUtil.getScreenWidth() / 2 - 56;
  }

  // Icon sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 40.0;
  static const double iconNotify = 64.0;

  // Font sizes
  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 16.0;
  static const double fontSizeLg = 18.0;

  // AppBar
  static const double verticalCenterAppBar = 28.0;

  // Button sizes
  static const double buttonHeight = 18.0;
  static const double buttonRadius = 12.0;
  static const double buttonLgRadius = 20.0;
  static const double buttonWidth = 120.0;
  static const double buttonElevation = 4.0;

  // Appbar height
  static const double appBarHeight = 56.0;

  // Image sizes
  static const double imageThumbSize = 80.0;

  // Default spacing between sections
  static const double defaultSpace = 24.0;
  static const double spaceBetweenItemsHorizontal = 8.0;
  static const double spaceBetweenItemsVertical = 16.0;
  static const double spaceBetweenItemsSm = 4.0;
  static const double spaceBetweenItemsMd = 8.0;
  static const double spaceBetweenItemsLg = 16.0;
  static const double spaceBetweenItemsXl = 32.0;
  static const double spaceBetweenSections = 32.0;

  // Border radius
  static const double borderRadiusSm = 4.0;
  static const double borderRadiusMd = 8.0;
  static const double borderRadiusLg = 12.0;
  static const double borderRadiusCircle = 100000000;

  static const double bottomNavigationBarHeight = 90.0;


  // Divider height
  static const double dividerHeight = 1.0;
  static const double dividerThickness = 2.0;

  // Product item dimensions
  static const double productImageSize = 120.0;
  static const double productImageRadius = 16.0;
  static const double productItemHeight = 160.0;

  // Input field
  static const double inputFieldRadius = 12.0;
  static const double spaceBetweenInputFields = 16.0;

  // Card size
  static const double cardElevation = 8.0;
  static const double cardElevationSm = 2.0;
  static const double cardElevationMd = 4.0;
  static const double cardElevationLg = 6.0;

  static const double iconCardElevation = 2.0;
  static const double cardRadiusXs = 6.0;
  static const double cardRadiusSm = 10.0;
  static const double cardRadiusMd = 12.0;
  static const double cardRadiusLg = 16.0;

  // Image carousel height
  static const double foodImage = 110.0;
  static const double imageCarouselHeight = 200.0;
  static const double imageDialogSize = 200.0;
  static const double imageSm = 40.0;
  static const double imageMd = 80.0;
  static const double imageLg = 160.0;
  static const double imageXl = 320.0;
  static const double avatarMd = 50.0;


  // Loading indicator size
  static const double loadingIndicatorSize = 36.0;

    // Grid view spacing
  static const double gridViewSpacing = 16.0;

  // Line
  static const int lgMaxLines = 8;
  static const int mdMaxLines = 5;
  static const int smMaxLines = 3;
}