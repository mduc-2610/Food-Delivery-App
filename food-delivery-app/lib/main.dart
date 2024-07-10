import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/bars/menu_bar.dart';
import 'package:food_delivery_app/features/restaurant/home/views/home/home.dart';
import 'package:food_delivery_app/features/restaurant/menu_redirection.dart';
import 'package:food_delivery_app/features/user/food/views/home/home.dart';
import 'package:food_delivery_app/features/user/food/views/like/food_like.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/features/user/notification/views/notification/notification.dart';
import 'package:food_delivery_app/features/user/order/models/location.dart';
import 'package:food_delivery_app/features/user/order/views/history/order_history.dart';
import 'package:food_delivery_app/features/user/personal/views/profile/personal_profile.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/theme/theme.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocationModel(),
      child: MyApp(),
    ),);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: RestaurantMenuRedirection(),
    );
  }
}
