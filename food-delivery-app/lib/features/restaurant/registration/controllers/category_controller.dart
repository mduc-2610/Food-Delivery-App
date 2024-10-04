import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/restaurant_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/user/food/models/food/category.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/constants/variable.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final RxList<dynamic> categories = <dynamic>[].obs;
  final RxList<dynamic> selectedCategories = <dynamic>[].obs;
  final RxList<dynamic> disabledCategories = <dynamic>[].obs;
  final isLoading = false.obs;
  Restaurant? restaurant;

  CategoryController({ this.restaurant });

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    isLoading.value = true;
    if (restaurant == null) {
      restaurant = await RestaurantService.getRestaurant();
    }
    categories.value = await APIService<DishCategory>().list(pagination: false);

    if (restaurant != null && restaurant?.restaurantCategories != null) {
      final restaurantCategories = await APIService<RestaurantCategory>(
          fullUrl: restaurant?.restaurantCategories ?? '').list();

      if (restaurantCategories != null && restaurantCategories.isNotEmpty) {
        disabledCategories.value = restaurantCategories
            .where((restaurantCategory) => restaurantCategory?.isDisabled == true)
            .map((restaurantCategory) => restaurantCategory.category as DishCategory)
            .toList();
        selectedCategories.value = restaurantCategories
            .where((restaurantCategory) => restaurantCategory?.isDisabled == false)
            .map((restaurantCategory) => restaurantCategory.category as DishCategory)
            .toList();

      }
    }
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
  }


  void selectCategory(DishCategory category) {
    int selIndex = selectedCategories.indexWhere((cat) => cat.name == category.name);
    int disIndex = disabledCategories.indexWhere((cat) => cat.name == category.name);
    if (selectedCategories.length < TVar.activeCategories) {
      if(selIndex == -1) {
        selectedCategories.add(category);
        $print("add");
        if(disIndex != -1) {
          disabledCategories.removeAt(disIndex);
        }
      }
      else {
        $print("un add");
        selectedCategories.removeAt(selIndex);
        if(disIndex == -1) {
          disabledCategories.add(category);
        }
      }
    }
    else {
      Get.snackbar(
          "Error add category",
          "You can only have ${TVar.activeCategories} active categories",
          backgroundColor: TColor.error);
    }
  }

  void removeCategory(DishCategory category) {
    if(selectedCategories.contains(category)) {
      selectedCategories.remove(category);
      disabledCategories.add(category);
    }
    else {
      disabledCategories.remove(category);
      selectedCategories.add(category);
    }
  }

  Future<void> onSave() async {
    try {
      final restaurantData = {
        "categories": selectedCategories.map((category) => category.id).toList(),
        "disabled_categories": disabledCategories.map((category) => category.id).toList(),
      };
      $print(restaurantData);
      final [statusCode, headers, data] = await APIService<Restaurant>().update(
        restaurant?.id, restaurantData,);
      if (statusCode == 200 || statusCode == 201) {
        restaurant = data;
      }
    }
    catch(e) {
      restaurant = await APIService<Restaurant>().retrieve(restaurant?.id ?? '');
    }
  }
}
