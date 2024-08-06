
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:get/get.dart';

class RestaurantListController extends GetxController {
  static RestaurantListController get instance => Get.find();

  Rx<bool> isLoading = true.obs;
  List<Restaurant> restaurants = [];


  @override
  void onInit() {
    super.onInit();
    initializeRestaurants();
  }

  Future<void> initializeRestaurants() async {
    restaurants = await APIService<Restaurant>().list();
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
  }
}