
import 'package:food_delivery_app/common/controllers/list/food_list_controller.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/data/socket_services/socket_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/features/user/order/models/promotion.dart';
import 'package:food_delivery_app/features/user/order/views/promotion/order_promotion.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderBasketController extends GetxController {
  static OrderBasketController get instance => Get.find();
  final restaurantDetailController = RestaurantDetailController.instance;
  final foodListController = FoodListController.instance;
  SocketService? orderSocket;
  List<String> chosenPromotionIds = [];
  List<RestaurantPromotion> chosenPromotions = [];

  Rx<bool> isLoading = true.obs;
  Order? order;

  @override
  void onInit() {
    super.onInit();
    orderSocket = SocketService<Order>();
    orderSocket?.connect();
    initialize();
  }

  @override
  void onClose() {
    orderSocket?.disconnect();
    super.onClose();
  }


  Future<void> initialize() async {
    isLoading.value = true;
    final [statusCode, headers, response] = await APIService<Order>().create({
      'cart': restaurantDetailController.user?.restaurantCart?.id
    }, );
    if(statusCode == 200 || statusCode == 201) {
      order = response;
    }
    else {
      order = await APIService<Order>().retrieve(restaurantDetailController.user?.restaurantCart?.id ?? "");
      update();
    }

    foodListController.order.value = order;
    $print("CHECK: ${foodListController.order.value?.cart.cartDishes}");
    Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();

  }

  Future<void> onPromotionPressed() async {
    final result = await Get.to(() => OrderPromotionView(
      order: foodListController.order.value,)
    ) as Map<String, dynamic>?;
    if(result?["order"] != null) {
      foodListController.order.value = result?["order"];
      order = result?["order"];
    }
    chosenPromotionIds = result?["chosenPromotionIds"] ?? [];
    // await controller.initialize();
    // $print("_ORDER: ${result?["order"]}");
    // $print("_ORDER: ${result?["chosenPromotionIds"]}");
  }

  Future<void> onDeletePromotion(RestaurantPromotion? promotion) async {
    try {
      final [statusCode, headers, data] = await APIService<Order>().update(order?.id, {
        'delete_restaurant_promotion': promotion?.id
      });
      foodListController.order.value = data;
      $print([statusCode, headers, data]);
    }
    catch(e) {
      Get.snackbar(
        "Error delete",
        "An error occurred when delete promotion!",
        backgroundColor: TColor.errorSnackBar
      );
    }
  }
}
