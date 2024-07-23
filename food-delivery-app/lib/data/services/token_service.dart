import 'dart:convert';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static Future<void> saveToken(Token token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', json.encode(token.toJson()));
  }

  static Future<Token?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenStr = prefs.getString('token');
    if (tokenStr != null && tokenStr != "") {
      Token token = Token.fromJson(json.decode(tokenStr));
      return token;
    }
    return null;
  }

  static Future<void> deleteToken() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setString('token', '');
  }

}
