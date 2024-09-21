import 'dart:convert';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/token_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DelivererService {
  final Token? token;

  DelivererService(this.token);

  // Future<void> saveUser(User user) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('user', json.encode(user.toJson()));
  // }
  //
  // Future<User?> getUserFromLS() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final userStr = prefs.getString('user');
  //   if (userStr != null && userStr.isNotEmpty) {
  //     final user = User.fromJson(json.decode(userStr));
  //     return user;
  //   }
  //   return null;
  // }
  //
  // static Future<void> deleteUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('token', '');
  // }

  static Future<dynamic> getDeliverer({ String? queryParams, bool getUser = false }) async {
    Deliverer? deliverer;
    final user = await APIService<User>(endpoint: 'account/user/me',
        pagination: false, ).list(single: true);
    if(getUser) {
      try {
        deliverer = await APIService<Deliverer>(queryParams: queryParams ?? "").retrieve(user?.deliverer ?? '');
        return [user, deliverer];
      }
      catch(e) {
        $print("NOT FOUND DELIVERER");
        return [user, null];
      }
    }
    return deliverer;
  }
}
