import 'dart:convert';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/token_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantService {
  final Token? token;

  RestaurantService(this.token);


  static Future<dynamic> getRestaurant({ String? queryParams, bool getUser = false }) async {
    Restaurant? restaurant;
    final user = await APIService<User>(endpoint: 'account/user/me',
      pagination: false, ).list(single: true);
      try {
        $print(user?.restaurant);
        restaurant = await APIService<Restaurant>(queryParams: queryParams ?? '', utf_8: true).retrieve(user?.restaurant ?? '');
        return (getUser) ? [user, restaurant] : restaurant;
      }
      catch(e) {
        $print(user?.restaurant);
        $print("NOT FOUND RESTAURANT");
        return (getUser) ? [user, null] : restaurant;
      }
  }
}
