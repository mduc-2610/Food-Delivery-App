import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:food_delivery_app/data/services/token_service.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/features/authentication/views/login/login.dart';
import 'package:food_delivery_app/features/authentication/views/splash/splash.dart';
import 'package:food_delivery_app/features/deliverer/registration/views/first/registration_first_step.dart';
import 'package:food_delivery_app/features/deliverer/registration/views/registration_step.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/registration_tab.dart';
import 'package:food_delivery_app/features/user/menu_redirection.dart';
import 'package:food_delivery_app/features/user/order/views/location/location_add.dart';
import 'package:food_delivery_app/main.reflectable.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:food_delivery_app/utils/theme/theme.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();
  Token? token = await TokenService.getToken();
  $print(token);
  runApp(
     MyApp(),
    );
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
        page = SplashView();
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
      // home: RegistrationFirstStepView(),
      home: page,
    );
  }
}
