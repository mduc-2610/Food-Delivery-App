
import 'package:food_delivery_app/common/controllers/bars/filter_bar_controller.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  static OrderHistoryController get instance => Get.find();

  final FilterBarController filterBarController = Get.put(FilterBarController("All"));
  User? user;
  var restaurantCarts = <RestaurantCart>[].obs;
  Rx<bool> isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCart();
  }

  Future<void> initializeCart() async {
    user = await UserService.getUser();
    if(user?.restaurantCarts != null) {
      restaurantCarts.value = await APIService<RestaurantCart>(fullUrl: user?.restaurantCarts ?? "").list();
    };
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();
  }

  Future<void> fetchFilterOrder(String filter) async {
    isLoading.value = true;
    restaurantCarts.value = await APIService<RestaurantCart>(fullUrl: user?.restaurantCarts ?? "", queryParams: "star_filter=${filter}").list();
    await Future.delayed(Duration(milliseconds: TTime.init));
    $print(restaurantCarts.length);
    isLoading.value = false;
    update();
  }

}