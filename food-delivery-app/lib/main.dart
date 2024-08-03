import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/token_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/features/authentication/views/login/login.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/models/review/review.dart';
import 'package:food_delivery_app/features/user/food/models/review/review_like.dart';
import 'package:food_delivery_app/features/user/food/restaurant/restaurant_detail.dart';
import 'package:food_delivery_app/features/user/food/views/search/restaurant_search.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/features/user/order/models/location.dart';
import 'package:food_delivery_app/main.reflectable.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:food_delivery_app/utils/theme/theme.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();
  Token? token = await TokenService.getToken();
  final service = APIService<User>(endpoint:'account/user/me', token: token, pagination: false,);

  runApp(
    ChangeNotifierProvider(
      create: (context) => LocationModel(),
      child: MyApp(),
    ),);
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = LoginView();
  @override
  void didChangeDependencies() async {
    Token? token = await TokenService.getToken();
    setState(() {
      if(token != null) {
        page = UserMenuRedirection();
      }
      else {
        page = LoginView();
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: UserMenuRedirection(),
    );
  }
}
