
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/views/splash/splash.dart';
import 'package:food_delivery_app/features/user/order/models/custom_location.dart';
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

  Future<void> handleApplyLocation() async {
    if (selectedIndex.value == firstSelectedIndex) {
      Get.back(result: false);
      return;
    }

    if (firstSelectedIndex != -1) {
      await APIService<UserLocation>(allNoBearer: true).update(
          userLocations[firstSelectedIndex].id,
          UserLocation(isSelected: false),
          patch: true
      );
    }

    if (selectedIndex.value != -1) {
      await APIService<UserLocation>(allNoBearer: true).update(
          userLocations[selectedIndex.value].id,
          UserLocation(isSelected: true),
          patch: true
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

  void handleLocationEdit(UserLocation? userLocation) async {
    final result = await Get.to(() => LocationAddView(
      initLocation: BaseLocation(
        latitude: userLocation?.latitude,
        longitude: userLocation?.longitude,
        address: userLocation?.address,
        name: userLocation?.name
      ),
    )) as Map<String, dynamic>?;
    if(result != null) {
      result["user"] = user?.id;
      $print("DATA: $result");

      final userLocationData = UserLocation.fromJson(result);
      $print("DATA: $userLocationData");
      try {

        int index = userLocations.indexWhere((location) => location == userLocation);
        final [statusCode, headers, data] = await APIService<UserLocation>(utf_8: true).update(userLocation?.id,
            userLocationData, patch: true);
        if(index != - 1) {
          userLocations[index] = data;
          userLocations.refresh();
        }
        $print("User chosen location: ${[statusCode, headers, data]}");
      }
      catch(e) {
        Get.snackbar("Error", "An error occurred");
      }
    }
  }

  void handleLocationDelete(UserLocation? userLocation) async {
    userLocations.removeWhere((location) => location == userLocation);
    if(userLocation?.id != null) {
      final result = await APIService<UserLocation>().delete(userLocation?.id ?? "");
      $print("DELETE SUCCESSFULLY: $result");
    }
  }
}
