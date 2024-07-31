import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@jsonSerializable
class SetPassword {
  final String password1;
  final String password2;
  final String user;

  SetPassword({
    required this.password1,
    required this.password2,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'password1': password1,
      'password2': password2,
      'user': user,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('SetPassword', toJson());
  }
}
