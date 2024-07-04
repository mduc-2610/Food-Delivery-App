import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/authentication/views/splash/splash.dart';
import 'package:food_delivery_app/features/food/views/category/food_category.dart';
import 'package:food_delivery_app/features/food/views/detail/food_detail.dart';
import 'package:food_delivery_app/features/food/views/home/home.dart';
import 'package:food_delivery_app/features/notification/views/notification.dart';
import 'package:food_delivery_app/utils/theme/theme.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: NotificationView(),
    );
  }
}
