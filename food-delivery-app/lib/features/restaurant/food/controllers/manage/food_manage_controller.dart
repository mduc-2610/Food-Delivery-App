import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/restaurant_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/restaurant/food/views/add/restaurant_add.dart';
import 'package:food_delivery_app/features/restaurant/food/views/add/widgets/food_add.dart';
import 'package:food_delivery_app/features/restaurant/food/views/add/widgets/promotion_add.dart';
import 'package:food_delivery_app/features/user/food/models/food/category.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/order/models/promotion.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class FoodManageController extends GetxController {
  static FoodManageController get instance => Get.find();

  Rx<bool> isLoading = true.obs;
  Restaurant? restaurant;
  RxList<Dish> dishes = <Dish>[].obs;
  List<DishCategory> categories = [];
  RxMap<String, List<Dish>> mapCategory = <String, List<Dish>>{}.obs;
  RxList<RestaurantPromotion> promotions = <RestaurantPromotion>[].obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(scrollListener);
    initialize();
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadPromotions();
      $print("info ${promotions.length} $nextPage");
    }
  }

  String? nextPage;

  Future<void> initialize() async {
    isLoading.value = true;
    restaurant = await RestaurantService.getRestaurant();
    $print(restaurant);
    categories = restaurant?.categories ?? [];
    await loadDishes();
    await loadPromotions(next: true);
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();
  }

  Future<void> loadPromotions({ bool next = false }) async {
    if (nextPage != null || next) {
      String url = nextPage ?? "${restaurant?.promotions}" ?? '';
      final [_result, info] = await APIService<RestaurantPromotion>
        (fullUrl: url, queryParams: "").list(next: true);
      promotions.addAll(_result);
      nextPage = info["next"];
      $print(info["next"]);
    }
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

  void handleDishDisable(Dish dish) async {
    final state = !(dish.isDisabled ?? false);
    final result = await APIService<Dish>().update(dish.id, {"is_disabled": state}, patch: true);
    if (result != null) {
      dishes.value = dishes.map((_dish) {
        if (_dish.id == dish.id) {
          _dish.isDisabled = state;
        }
        return _dish;
      }).toList();
      mapCategory.forEach((category, dishList) {
        mapCategory[category] = dishList.map((_dish) {
          if (_dish.id == dish.id) {
            _dish.isDisabled = state;
          }
          return _dish;
        }).toList();
      });
      update();
      $print("update disable dish: $result");
    }
  }

  void handleDishEditInformation(Dish dish) async {
    final created = await Get.to(() => RestaurantAddView(dishId: dish.id,), arguments: {'id': dish.id}) as bool?;
    if (created == true) {
      await initialize();
    }
  }

  void handlePromotionDisable(RestaurantPromotion promotion) async {
    final state = !(promotion.isDisabled);
    final result = await APIService<RestaurantPromotion>().update(promotion.id, {"is_disabled": state}, patch: true);
    if (result != null) {
      promotions.value = promotions.map((_promotion) {
        if (_promotion.id == promotion.id) {
          _promotion.isDisabled = state;
          _promotion.isAvailable = state;
        }
        return _promotion;
      }).toList();
      update();
      $print("update disable promotion: $result");
    }
  }

  void handlePromotionEditInformation(RestaurantPromotion promotion) async {
    final created = await Get.to(() => RestaurantAddView(promotionId: promotion.id,), arguments: {'id': promotion.id}) as bool?;
    if (created == true) {
      nextPage == null;
      promotions.clear();
      await initialize();
      $print("FIRST PROMOTION NAME ${promotions[0].name}");
      // $print("ni");
    }
  }
}