
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RestaurantListController extends GetxController {
  static RestaurantListController get instance => Get.find();

  Rx<bool> isLoading = true.obs;
  var restaurants = [];
  final scrollController = ScrollController();
  final searchTextController = TextEditingController();
  String? category;
  String? searchResult;

  RestaurantListController({
    this.category,
    this.searchResult,
  });

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    initializeRestaurants();
  }

  String? _nextPage;

  Future<void> initializeRestaurants({ bool loadMore = false, String? fullUrl, String? queryParams, bool isSearch = false }) async {
    if(!loadMore || _nextPage != null) {
      String params =
      (searchResult != null || queryParams != null || searchTextController.text != "")
          ? "name=${(searchTextController.text != "") ? searchTextController.text : (searchResult ?? queryParams ?? '')}" : ""
          + ((category != null) ? "${queryParams != null ? "&" : ""}category=$category" : "");
      final [_result, _info] = await APIService<Restaurant>(fullUrl: fullUrl ?? '', queryParams: params).list(next: true);
      if(!isSearch) {
        restaurants.addAll(_result);
      }else {
        restaurants = _result;
      }
      _nextPage = _info["next"];
      update();

    }
    if(!loadMore) {
      await Future.delayed(Duration(milliseconds: TTime.init));
      isLoading.value = false;
    }
  }

  void onSearch() {
    $print("searchText: ${searchTextController.text}");
    initializeRestaurants(queryParams: "${searchTextController.text}", isSearch: true);
    $print(restaurants.length);
  }

  void _scrollListener() {
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      initializeRestaurants(loadMore: true, fullUrl: _nextPage);
    }
  }
}