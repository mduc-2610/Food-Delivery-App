
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderBasketController extends GetxController {
  static OrderBasketController get instance => Get.find();
  final restaurantDetailController = RestaurantDetailController.instance;
  User? user;
  Rx<bool> isLoading = true.obs;
  Order? order;
  @override
  void onInit() {
    super.onInit();
    initializeUser();
    $print("INIT");
  }

  Future<void> initializeUser() async {
    user = await UserService.getUser(queryParams: "restaurant=${restaurantDetailController.restaurantId}");
    $print(restaurantDetailController.restaurantCart?.id);
    $print(restaurantDetailController.restaurantCart?.isCreatedOrder);
    if(restaurantDetailController.restaurantCart?.isCreatedOrder == false) {
      final [statusCode, headers, response] = await APIService<Order>().create({
        'cart': restaurantDetailController.restaurantCart?.id
      }, noBearer: true);
      if(statusCode == 200 || statusCode == 201) {
        order = response;
        restaurantDetailController.restaurantCart?.isCreatedOrder = true;
      }
      else {
        order = await APIService<Order>().retrieve(restaurantDetailController.restaurantCart?.id ?? "");
        $print(order);
      }

    } else {
      order = await APIService<Order>().retrieve(restaurantDetailController.restaurantCart?.id ?? "");
      $print(order);
    }
    Future.delayed(Duration(milliseconds: 10000));
    isLoading.value = false;
    update();

  }

  void increaseQuantity(RestaurantCartDish cartDish)  async{
    cartDish.quantity += 1;
    $print(cartDish.price);
    user?.restaurantCart?.order?.total += cartDish.price;
    update();
  }

  void decreaseQuantity(RestaurantCartDish cartDish) {
    if (cartDish.quantity > 1) {
      cartDish.quantity -= 1;
      $print(cartDish.price);
    } else {
      user?.restaurantCart?.cartDishes.remove(cartDish);
    }
    user?.restaurantCart?.order?.total -= cartDish.price;

    update();
  }
}
