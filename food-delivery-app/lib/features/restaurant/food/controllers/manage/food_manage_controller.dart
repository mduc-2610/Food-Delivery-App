import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/restaurant_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/user/food/models/food/category.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class FoodManageController extends GetxController {
  static FoodManageController get instance => Get.find();
  Rx<bool> isLoading = true.obs;
  Restaurant? restaurant;
  List<Dish> dishes = [];
  List<DishCategory> categories = [];
  Map<String, List<Dish>> mapCategory = {};

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    $print("INIT");
    isLoading.value = true;
    restaurant = await RestaurantService.getRestaurant();
    $print(restaurant);
    categories = restaurant?.categories ?? [];
    await loadDishes();
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
  }

  Future<void> loadDishes() async {
    for (var category in categories) {
      mapCategory[category.name ?? ""] = await APIService<Dish>(
        fullUrl: restaurant?.dishes ?? "",
        queryParams: 'category=${category.id}',
      ).list(pagination: false);
      if (mapCategory[category.name ?? ""]!.isNotEmpty) {
        dishes = mapCategory[category.name ?? ""]!;
      }
    }
  }
}