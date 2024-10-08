import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/restaurant_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/restaurant/food/views/add/restaurant_add.dart';
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
  TextEditingController searchController = TextEditingController();
  RxString searchQuery = ''.obs;
  RxInt currentTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(scrollListener);
    initialize();
  }

  void setCurrentTabIndex(int index) {
    currentTabIndex.value = index;
    searchController.clear();
    searchQuery.value = '';
    _performSearch();
  }

  void triggerSearch() {
    searchQuery.value = searchController.text;
    _performSearch();
  }

  Future<void> _performSearch() async {
    if (currentTabIndex.value == 0) {
      await _searchPromotions();
    } else {
      await _searchDishes();
    }
  }

  Future<void> _searchPromotions() async {
    promotions.clear();
    nextPage = null;
    await loadPromotions(next: true);
  }

  Future<void> _searchDishes() async {
    dishes.clear();
    mapCategory.clear();
    await loadDishes();
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadPromotions();
    }
  }

  String? nextPage;

  Future<void> initialize() async {
    isLoading.value = true;
    restaurant = await RestaurantService.getRestaurant();
    categories = restaurant?.categories ?? [];
    await loadDishes();
    await loadPromotions(next: true);
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
    update();
  }

  Future<void> loadPromotions({bool next = false}) async {
    if (nextPage != null || next) {
      String url = nextPage ?? "${restaurant?.promotions}" ?? '';
      final queryParams = searchQuery.isNotEmpty ? "name=${searchQuery.value}" : "";
      final [_result, info] = await APIService<RestaurantPromotion>(fullUrl: url, queryParams: queryParams).list(next: true);
      promotions.addAll(_result);
      nextPage = info["next"];
    }
  }

  Future<void> loadDishes() async {
    for (var category in categories) {
      String queryParams = 'category=${category.id}';
      if (searchQuery.isNotEmpty) {
        queryParams += '&name=${searchQuery.value}';
      }
      mapCategory[category.name ?? ""] = await APIService<Dish>(
        fullUrl: restaurant?.dishes ?? "",
        queryParams: queryParams,
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
      nextPage == null;
      dishes.clear();
      categories.clear();
      mapCategory.clear();
      promotions.clear();
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
      nextPage = null;
      promotions.clear();
      await loadPromotions(next: true);
      $print("FIRST PROMOTION NAME ${promotions[0].name}");
      // $print("ni");
    }
  }
}