import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:get/get.dart';

class UserBasketController extends GetxController {
  static UserBasketController get instance => Get.find();

  User? user;
  List<RestaurantCart> restaurantCarts = [];
  Rx<bool> isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCart();
  }

  Future<void> initializeCart() async {
    user = await UserService.getUser();
    if(user?.restaurantCarts != null) {
      restaurantCarts = await APIService<RestaurantCart>(fullUrl: user?.restaurantCarts ?? "").list();
    };
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();
  }
}