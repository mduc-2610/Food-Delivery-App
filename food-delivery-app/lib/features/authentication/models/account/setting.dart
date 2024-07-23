import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class UserSetting {
  final User? user;
  final bool? notification;
  final bool? darkMode;
  final bool? sound;
  final bool? automaticallyUpdated;
  final String? language;

  UserSetting({
    required this.user,
    required this.notification,
    required this.darkMode,
    required this.sound,
    required this.automaticallyUpdated,
    required this.language,
  });

  UserSetting.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['user']),
        notification = json['notification'],
        darkMode = json['dark_mode'],
        sound = json['sound'],
        automaticallyUpdated = json['automatically_updated'],
        language = json['language'];

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'notification': notification,
      'dark_mode': darkMode,
      'sound': sound,
      'automatically_updated': automaticallyUpdated,
      'language': language,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('UserSetting', {
      'user': user,
      'notification': notification,
      'darkMode': darkMode,
      'sound': sound,
      'automaticallyUpdated': automaticallyUpdated,
      'language': language,
    });
  }
}

class UserSecuritySetting {
  final UserSetting? setting;
  final bool? faceId;
  final bool? touchId;
  final bool? pinSecurity;

  UserSecuritySetting({
    required this.setting,
    required this.faceId,
    required this.touchId,
    required this.pinSecurity,
  });

  UserSecuritySetting.fromJson(Map<String, dynamic> json)
      : setting = UserSetting.fromJson(json['setting']),
        faceId = json['face_id'],
        touchId = json['touch_id'],
        pinSecurity = json['pin_security'];

  Map<String, dynamic> toJson() {
    return {
      'setting': setting?.toJson(),
      'face_id': faceId,
      'touch_id': touchId,
      'pin_security': pinSecurity,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString('UserSecuritySetting', {
      'setting': setting,
      'faceId': faceId,
      'touchId': touchId,
      'pinSecurity': pinSecurity,
    });
  }
}