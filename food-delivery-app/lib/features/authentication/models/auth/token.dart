import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Token {
  String access;
  String refresh;

  Token.fromJson(Map<String, dynamic> json)
    : access = json['access'],
      refresh = json['refresh'];

  Map<String, dynamic> toJson() {
    return {
      'access': access,
      'refresh': refresh,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString("Token", {
      'access': access,
      'refresh': refresh
    });
  }
}