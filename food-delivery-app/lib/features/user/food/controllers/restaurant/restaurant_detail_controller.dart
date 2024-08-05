import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/user/food/models/food/category.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/views/detail/food_detail.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RestaurantDetailController extends GetxController {
  static RestaurantDetailController get instance => Get.find();

  Token? token;
  String? restaurantId;
  Restaurant? restaurant;
  List<DishCategory> categories = [];
  List<Dish> dishes = [];
  Map<String, List<Dish>> mapCategory = {};

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      restaurantId = Get.arguments['id'];
      initializeRestaurant(restaurantId ?? "");
    }
  }

  Future<void> initializeRestaurant(String id) async {
    restaurant = await APIService<Restaurant>(token: token).retrieve(id);
    categories = restaurant?.categories ?? [];
    dishes = await APIService<Dish>(token: token, fullUrl: restaurant?.dishes ?? "", queryParams: 'category=${categories[0].id}').list();
    $print(restaurantId);
    for(var category in categories) {
      mapCategory[category.name ?? ""] =
          await APIService<Dish>(
              token: token,
              fullUrl: restaurant?.dishes ?? "",
              queryParams: 'category=${category.id}').list();
      if(mapCategory[category.name ?? ""] != []) dishes = mapCategory[category.name ?? ""] ?? [];
    }
    $print(mapCategory);
  }

  void getToFoodDetail() {
    Get.to(() => FoodDetailView());
  }
}