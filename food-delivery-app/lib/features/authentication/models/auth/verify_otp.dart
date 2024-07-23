import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class VerifyOTP {
  final String code;
  final String user;
  final bool isLogin;

  VerifyOTP({
    required this.code,
    required this.user,
    required this.isLogin,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'user': user,
      'is_login': isLogin,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('VerifyOTP', toJson());
  }
}
