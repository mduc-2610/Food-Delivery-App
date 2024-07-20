import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

class Setting {
  final User? user;
  final bool? notification;
  final bool? darkMode;
  final bool? sound;
  final bool? automaticallyUpdated;
  final String? language;

  Setting({
    required this.user,
    required this.notification,
    required this.darkMode,
    required this.sound,
    required this.automaticallyUpdated,
    required this.language,
  });

  Setting.fromJson(Map<String, dynamic> json)
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
    return THelperFunction.formatToString('Setting', {
      'user': user,
      'notification': notification,
      'darkMode': darkMode,
      'sound': sound,
      'automaticallyUpdated': automaticallyUpdated,
      'language': language,
    });
  }
}

class SecuritySetting {
  final Setting? setting;
  final bool? faceId;
  final bool? touchId;
  final bool? pinSecurity;

  SecuritySetting({
    required this.setting,
    required this.faceId,
    required this.touchId,
    required this.pinSecurity,
  });

  SecuritySetting.fromJson(Map<String, dynamic> json)
      : setting = Setting.fromJson(json['setting']),
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
    return THelperFunction.formatToString('SecuritySetting', {
      'setting': setting,
      'faceId': faceId,
      'touchId': touchId,
      'pinSecurity': pinSecurity,
    });
  }
}