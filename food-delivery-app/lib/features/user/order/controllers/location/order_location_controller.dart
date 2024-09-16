
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/views/splash/splash.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderLocationController extends GetxController {
  static OrderLocationController get instance => Get.find();

  User? user;
  List<UserLocation> userLocations = [];
  var isLoading = true.obs;
  var selectedIndex = (-1).obs;
  int firstSelectedIndex = -1;

  @override
  void onInit() {
    super.onInit();
    initializeLocation();
  }

  Future<void> initializeLocation() async {
    user = await UserService.getUser();
    userLocations = await APIService<UserLocation>(fullUrl: user?.locations ?? "").list();

    for (int i = 0; i < userLocations.length; i++) {
      if (userLocations[i].isSelected) {
        selectedIndex.value = i;
        firstSelectedIndex = i;
        break;
      }
    }
    isLoading.value = false;
    update();
  }

  void selectLocation(int index) {
    if(index == selectedIndex.value) {
      selectedIndex.value = -1;
    }
    else {
      selectedIndex.value = index;
    }
    update();
  }

  void handleApplyLocation() async {
    if(firstSelectedIndex != -1) {
      final unselectedLocation = await APIService<UserLocation>(allNoBearer: true).update(
          userLocations[firstSelectedIndex].id,
          UserLocation(
              isSelected: !userLocations[firstSelectedIndex].isSelected
          ), patch: true
      );
    }

    if(selectedIndex.value != -1) {
      final selectedLocation = await APIService<UserLocation>(allNoBearer: true).update(
          userLocations[selectedIndex.value].id,
          UserLocation(
              isSelected: !userLocations[selectedIndex.value].isSelected
          ), patch: true
      );
    }
    Get.back(result: true);
  }
}
