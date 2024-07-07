import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/authentication/views/face_id/face_id.dart';
import 'package:food_delivery_app/features/authentication/views/splash/splash.dart';
import 'package:food_delivery_app/features/authentication/views/touch_id/touch_id.dart';
import 'package:food_delivery_app/features/food/views/category/food_category.dart';
import 'package:food_delivery_app/features/food/views/detail/food_detail_review.dart';
import 'package:food_delivery_app/features/notification/views/notification/notification.dart';
import 'package:food_delivery_app/features/order/models/location.dart';
import 'package:food_delivery_app/features/order/views/basket/order_basket.dart';
import 'package:food_delivery_app/features/order/views/cancel/order_cancel.dart';
import 'package:food_delivery_app/features/order/views/contact/order_driver_information.dart';
import 'package:food_delivery_app/features/order/views/location/order_location_add.dart';
import 'package:food_delivery_app/features/order/views/rating/order_rating_meal.dart';
import 'package:food_delivery_app/features/order/views/rating/order_rating_order.dart';
import 'package:food_delivery_app/features/order/views/history/order_history.dart';
import 'package:food_delivery_app/features/order/views/history/order_history_detail.dart';
import 'package:food_delivery_app/features/order/views/location/order_location.dart';
import 'package:food_delivery_app/features/order/views/promotion/order_promotion.dart';
import 'package:food_delivery_app/features/order/views/promotion/order_promotion_list.dart';
import 'package:food_delivery_app/features/payment/views/payment/widgets/payment_card.dart';
import 'package:food_delivery_app/features/payment/views/payment/payment_list.dart';
import 'package:food_delivery_app/features/personal/views/about_app/personal_about_app.dart';
import 'package:food_delivery_app/features/personal/views/help_center/personal_help_center.dart';
import 'package:food_delivery_app/features/personal/views/help_center/personal_help_detail.dart';
import 'package:food_delivery_app/features/personal/views/invite/personal_invite.dart';
import 'package:food_delivery_app/features/personal/views/message/personal_message.dart';
import 'package:food_delivery_app/features/personal/views/other_app/person_other_app.dart';
import 'package:food_delivery_app/features/personal/views/privacy_policy/personal_privacy_policy.dart';
import 'package:food_delivery_app/features/personal/views/profile/personal_profile.dart';
import 'package:food_delivery_app/features/personal/views/security/personal_security.dart';
import 'package:food_delivery_app/features/personal/views/term_of_service/personal_term_of_service.dart';
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
      home: OrderDriverInformationView(),
    );
  }
}
