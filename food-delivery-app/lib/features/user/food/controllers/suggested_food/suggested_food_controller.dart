import 'dart:async';

import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/models/weather.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuggestedFoodController extends GetxController {
  static SuggestedFoodController get instance => Get.find();

  final RxBool isLoadingPreferences = true.obs;
  final RxBool isLoadingWeather = true.obs;
  final RxList<Dish> preferenceBasedDishes = <Dish>[].obs;
  final RxList<Dish> weatherBasedDishes = <Dish>[].obs;
  final Rx<Weather?> weather = (null as Weather?).obs;

  final TextEditingController preferenceTextController = TextEditingController();
  final TextEditingController weatherTextController = TextEditingController();

  String? preferenceNextPage;
  String? weatherNextPage;
  int currentPreferencePage = 1;
  int totalPreferencePages = 1;
  int currentWeatherPage = 1;
  int totalWeatherPages = 1;

  bool isLoadingMorePreferences = false;
  bool isLoadingMoreWeather = false;
  bool preferencesCached = false;
  bool weatherCached = false;
  User? user;

  final ScrollController listScrollController = ScrollController();
  final ScrollController gridScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    initialize();

    // Add scroll listeners
    listScrollController.addListener(_handleListScroll);
    gridScrollController.addListener(_handleGridScroll);
  }

  @override
  void onClose() {
    listScrollController.dispose();
    gridScrollController.dispose();
    super.onClose();
  }

  void _handleListScroll() {
    if (listScrollController.position.pixels >= listScrollController.position.maxScrollExtent - 200) {
      if (!isLoadingMorePreferences && preferenceNextPage != null) {
        $print("Preferences ${preferenceNextPage}");
        loadPreferenceBasedDishes(loadMore: true);
      }
    }
  }

  void _handleGridScroll() {
    if (gridScrollController.position.pixels >= gridScrollController.position.maxScrollExtent - 200) {
      if (!isLoadingMoreWeather && weatherNextPage != null) {
        loadWeatherBasedDishes(loadMore: true);
      }
    }
  }

  Future<void> initialize() async {
    user = await UserService.getUser();
  }

  Future<void> loadPreferenceBasedDishes({bool refresh = false, bool loadMore = false}) async {
    if (!refresh && !loadMore && preferencesCached) return;

    if (refresh) {
      preferenceNextPage = null;
      currentPreferencePage = 1;
      preferenceBasedDishes.clear();
    }

    if (loadMore) {
      if (isLoadingMorePreferences || preferenceNextPage == null) return;
      isLoadingMorePreferences = true;
    } else {
      isLoadingPreferences.value = true;
    }

    try {
      final response = await APIService<Dish>(
        endpoint: preferenceNextPage == null ? 'food/dish/suggested-dish' : "",
        fullUrl: preferenceNextPage ?? "",
        queryParams: preferenceNextPage == null ? "p_name=${preferenceTextController.text}&flag=preferences&page=$currentPreferencePage" : "",
      ).list(next: true);

      final pagination = response[1];
      final result = response[0];

      $print("next Page ${pagination["next"]} ${pagination["count"]}");
      preferenceNextPage = pagination["next"];
      totalPreferencePages = pagination["total_pages"] ?? 1;
      currentPreferencePage = pagination["current_page"] ?? 1;

      if (result.isNotEmpty) {
        preferenceBasedDishes.addAll(result);
        preferencesCached = true;
      }
    } catch (e) {
      print('Error loading preference based dishes: $e');
    } finally {
      isLoadingPreferences.value = false;
      isLoadingMorePreferences = false;
    }
  }

  Future<void> loadWeatherBasedDishes({bool refresh = false, bool loadMore = false}) async {
    if (!refresh && !loadMore && weatherCached) return;

    if (refresh) {
      weatherNextPage = null;
      currentWeatherPage = 1;
      weatherBasedDishes.clear();
    }

    if (loadMore) {
      if (isLoadingMoreWeather || weatherNextPage == null) return;
      isLoadingMoreWeather = true;
    } else {
      isLoadingWeather.value = true;
    }

    try {
      if (weather.value == null) {
        weather.value = await APIService<Weather>(queryParams: "q=hanoi,vn").list(single: true);
      }

      final response = await APIService<Dish>(
        endpoint: weatherNextPage == null ? 'food/dish/suggested-dish' : "",
        fullUrl: weatherNextPage ?? "",
        queryParams: weatherNextPage == null ? "w_name=${weatherTextController.text}&flag=temperature&temperature=${weather.value?.temperature}&page=$currentWeatherPage" : "",
      ).list(next: true);

      final pagination = response[1];
      final result = response[0];

      weatherNextPage = pagination["next"];
      totalWeatherPages = pagination["total_pages"] ?? 1;
      currentWeatherPage = pagination["current_page"] ?? 1;

      if (result.isNotEmpty) {
        weatherBasedDishes.addAll(result);
        weatherCached = true;
      }
    } catch (e) {
      print('Error loading weather based dishes: $e');
    } finally {
      isLoadingWeather.value = false;
      isLoadingMoreWeather = false;
    }
  }

  Future<void> refreshCurrentTab(int tabIndex) async {
    if (tabIndex == 0) {
      await loadPreferenceBasedDishes(refresh: true);
    } else {
      await loadWeatherBasedDishes(refresh: true);
    }
  }

  Future<void> preferenceSearch() async {
    preferenceNextPage = null;
    currentPreferencePage = 1;
    totalPreferencePages = 1;
    preferencesCached = false;
    preferenceBasedDishes.clear();

    await loadPreferenceBasedDishes(refresh: true);
  }

  Future<void> weatherSearch() async {
    weatherNextPage = null;
    currentWeatherPage = 1;
    totalWeatherPages = 1;
    weatherCached = false;
    weatherBasedDishes.clear();

    await loadWeatherBasedDishes(refresh: true);
  }

  final _debouncer = Debouncer(milliseconds: 500);

  void onPreferenceSearchChanged(String value) {
    _debouncer.run(() {
      preferenceSearch();
    });
  }

  void onWeatherSearchChanged(String value) {
    _debouncer.run(() {
      weatherSearch();
    });
  }

  bool get hasMorePreferences => preferenceNextPage != null;
  bool get hasMoreWeather => weatherNextPage != null;
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}