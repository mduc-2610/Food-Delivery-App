import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/restaurant_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/restaurant/food/views/add/food_add.dart';
import 'package:food_delivery_app/features/user/food/models/food/category.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class FoodManageController extends GetxController {
  static FoodManageController get instance => Get.find();
  Rx<bool> isLoading = true.obs;
  Restaurant? restaurant;
  RxList<Dish> dishes = <Dish>[].obs;
  List<DishCategory> categories = [];
  RxMap<String, List<Dish>> mapCategory = <String, List<Dish>>{}.obs; // Changed to RxMap

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    isLoading.value = true;
    restaurant = await RestaurantService.getRestaurant();
    $print(restaurant);
    categories = restaurant?.categories ?? [];
    await loadDishes();
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();
  }

  Future<void> loadDishes() async {
    for (var category in categories) {
      mapCategory[category.name ?? ""] = await APIService<Dish>(
        fullUrl: restaurant?.dishes ?? "",
        queryParams: 'category=${category.id}',
      ).list(pagination: false);
      if (mapCategory[category.name ?? ""]!.isNotEmpty) {
        dishes.addAll(mapCategory[category.name ?? ""]!);
      }
    }
  }

  void handleDisable(Dish dish) async {
    final state = !(dish.isDisabled ?? false);

    // Update the dish state in the backend
    final result = await APIService<Dish>().update(dish.id, {
      "is_disabled": state
    }, patch: true);

    if (result != null) {
      // Update in `dishes`
      dishes.value = dishes.map((_dish) {
        if (_dish.id == dish.id) {
          _dish.isDisabled = state;
        }
        return _dish;
      }).toList();

      // Update in `mapCategory` (now reactive)
      mapCategory.forEach((category, dishList) {
        mapCategory[category] = dishList.map((_dish) {
          if (_dish.id == dish.id) {
            _dish.isDisabled = state;
          }
          return _dish;
        }).toList();
      });

      // Update the UI
      update();
      $print("update disable: $result");
    }
  }

  void handleEditInformation(Dish dish) async {
    final created = await Get.to(() => FoodAddView(), arguments: {
      'id': dish.id
    }) as bool?;
    if (created == true) {
      await initialize();
    }
  }
}
