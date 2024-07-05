import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/food/views/category/food_category.dart';
import 'package:food_delivery_app/features/food/views/detail/food_detail_review.dart';
import 'package:food_delivery_app/features/notification/views/notification/notification.dart';
import 'package:food_delivery_app/features/order/views/history/order_history.dart';
import 'package:food_delivery_app/features/order/views/history/order_history_detail.dart';
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
      themeMode: ThemeMode.light,
      home: OrderHistoryView(),
    );
  }
}
