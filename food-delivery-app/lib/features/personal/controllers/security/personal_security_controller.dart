import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/setting.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/user/personal/controller/personal_profile_controller.dart';

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
    faceId.value = securitySetting?.faceId ?? false;
    touchId.value = securitySetting?.touchId ?? false;
    pinSecurity.value = securitySetting?.pinSecurity ?? false;
    super.onInit();
  }

  void toggleTouchId(bool value) {
    securitySetting?.touchId = value;
    updateSecuritySetting(securitySetting!);
    update();
  }

  void toggleFaceId(bool value) {
    securitySetting?.faceId = value;
    updateSecuritySetting(securitySetting!);
    update();
  }

  void togglePinSecurity(bool value) {
    securitySetting?.pinSecurity = value;
    updateSecuritySetting(securitySetting!);
    update();
  }

  Future<void> updateSecuritySetting(UserSecuritySetting securitySetting) async {
      await APIService<UserSecuritySetting>().update(securitySetting.setting, securitySetting, patch: true);
  }
}
