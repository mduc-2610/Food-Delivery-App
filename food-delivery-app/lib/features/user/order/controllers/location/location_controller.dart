
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/views/splash/splash.dart';
import 'package:food_delivery_app/features/user/order/views/location/location_add.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class LocationSelectController extends GetxController {
  static LocationSelectController get instance => Get.find();

  User? user;
  RxList<UserLocation> userLocations = <UserLocation>[].obs;
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
    userLocations.value = await APIService<UserLocation>(fullUrl: user?.locations ?? "", utf_8: true).list(pagination: false);

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

  void handleLocationAdd() async {
    final result = await Get.to(() => LocationAddView()) as Map<String, dynamic>?;
    if(result != null) {
      result["user"] = user?.id;
      $print("DATA: $result");

      final userLocationData = UserLocation.fromJson(result);
      $print("DATA: $userLocationData");
      try {
        final [statusCode, headers, data] = await APIService<UserLocation>(utf_8: true).create(userLocationData);
        userLocations.insert(0, data);
        $print("User chosen location: ${[statusCode, headers, data]}");
      }
      catch(e) {
        Get.snackbar("Error", "An error occurred");
      }
    }
  }
}
