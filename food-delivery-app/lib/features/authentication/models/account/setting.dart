import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class UserSetting {
  final String? user;
  final UserSecuritySetting? securitySetting;
  bool? notification;
  bool? darkMode;
  bool? sound;
  bool? automaticallyUpdated;
  String? language;

  UserSetting({
    this.user,
    this.securitySetting,
    this.notification,
    this.darkMode,
    this.sound,
    this.automaticallyUpdated,
    this.language,
  });

  UserSetting.fromJson(Map<String, dynamic> json)
      : user = json['user'],
        securitySetting = UserSecuritySetting.fromJson(json['security_setting']),
        notification = json['notification'],
        darkMode = json['dark_mode'],
        sound = json['sound'],
        automaticallyUpdated = json['automatically_updated'],
        language = json['language'];

  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = {
      'user': user,
      'security_setting': securitySetting?.toJson(patch: patch),
      'notification': notification,
      'dark_mode': darkMode,
      'sound': sound,
      'automatically_updated': automaticallyUpdated,
      'language': language,
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class UserSecuritySetting {
  final String? setting;
  bool? faceId;
  bool? touchId;
  bool? pinSecurity;

  UserSecuritySetting({
    this.setting,
    this.faceId,
    this.touchId,
    this.pinSecurity,
  });

  UserSecuritySetting.fromJson(Map<String, dynamic> json)
      : setting = json['setting'],
        faceId = json['face_id'],
        touchId = json['touch_id'],
        pinSecurity = json['pin_security'];

  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = {
      'setting': setting,
      'face_id': faceId,
      'touch_id': touchId,
      'pin_security': pinSecurity,
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}
