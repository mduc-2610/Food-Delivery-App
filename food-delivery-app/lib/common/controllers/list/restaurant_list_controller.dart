
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/token_service.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RestaurantListController extends GetxController {
  static RestaurantListController get instance => Get.find();

  Token? token;
  List<Restaurant> restaurants = [];


  @override
  void onInit() {
    super.onInit();
    initializeRestaurants();
  }

  Future<void> initializeRestaurants() async {
    token = await TokenService.getToken();
    restaurants = await APIService<Restaurant>(token: token).list();
  }
}