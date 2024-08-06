import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/user/personal/controller/personal_profile_controller.dart';
import 'package:food_delivery_app/features/authentication/models/account/setting.dart';

class PersonalSecurityController extends GetxController {
  final PersonalProfileController _personalProfileController = PersonalProfileController.instance;

  UserSetting? setting;
  UserSecuritySetting? securitySetting;
  Rx<bool> faceId = false.obs;
  Rx<bool> touchId = false.obs;
  Rx<bool> pinSecurity = false.obs;

  @override
  void onInit() {
    setting = _personalProfileController.setting;
    securitySetting = setting?.securitySetting;
    $print(securitySetting);
    faceId.value = securitySetting?.faceId ?? false;
    touchId.value = securitySetting?.touchId ?? false;
    pinSecurity.value = securitySetting?.pinSecurity?? false;
    super.onInit();

  }
  void toggleFaceId(bool value) {
    faceId.value = value;
    securitySetting?.faceId = value;
    updateSecuritySetting(UserSecuritySetting(faceId: faceId.value));
  }

  void toggleTouchId(bool value) {
    touchId.value = value;
    securitySetting?.touchId = value;
    updateSecuritySetting(UserSecuritySetting(touchId: touchId.value));
  }

  void togglePinSecurity(bool value) {
    pinSecurity.value = value;
    securitySetting?.pinSecurity = value;
    updateSecuritySetting(UserSecuritySetting(pinSecurity: pinSecurity.value));
  }

  Future<void> updateSecuritySetting(UserSecuritySetting updatedSecuritySettings) async {
    $print(updatedSecuritySettings);
    await APIService<UserSecuritySetting>().update(securitySetting?.setting, updatedSecuritySettings, patch: true);
  }
}
