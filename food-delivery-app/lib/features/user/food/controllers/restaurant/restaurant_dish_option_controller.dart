import 'package:food_delivery_app/common/controllers/card/food_card_controller.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RestaurantDishOptionController extends GetxController {
  static RestaurantDishOptionController get instance => Get.find();

  final String? dishId;
  Dish? dish;
  var isLoading = true.obs;
  var mapItemChosen = {}.obs;

  late final FoodCardController foodCardController;
  late final RestaurantDetailController restaurantDetailController;

  RestaurantDishOptionController(this.dishId);

  @override
  void onInit() {
    super.onInit();
    initializeDish();
    foodCardController = Get.put(FoodCardController(dish), tag: dish?.id.toString());
    restaurantDetailController = RestaurantDetailController.instance;
  }

  Future<void> initializeDish() async {
    dish = await APIService<Dish>().retrieve(dishId ?? "");
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    dish?.options.forEach((option) {
      mapItemChosen[option.name ?? ''] = {
        for (var item in option.items ?? []) item?.id: false,
      };
    });
    update();

  }

  void updateItemChosen(String optionName, String? itemId, bool value) {
    if (itemId == null) return;

    if (optionName == 'Sizes' && value) {
      mapItemChosen[optionName]?.updateAll((key, _) => false);
    }

    mapItemChosen[optionName]?[itemId] = value;
    mapItemChosen.refresh();
  }
}
