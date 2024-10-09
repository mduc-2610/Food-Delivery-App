import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class RestaurantListController extends GetxController {
  static RestaurantListController get instance => Get.find();
  Rx<bool> isLoading = true.obs;
  User? user;
  final bool isLike;
  RxList<Restaurant> restaurants = <Restaurant>[].obs;
  final scrollController = ScrollController();
  final searchTextController = TextEditingController();
  String? category;
  String? searchResult;
  int dishPageSize = 3;

  RestaurantListController({
    this.category,
    this.searchResult,
    this.isLike = false,
  });

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    initializeRestaurants();
  }

  String? _nextPage;

  Future<void> initializeRestaurants({ bool loadMore = false, String? fullUrl, String? queryParams, bool isSearch = false }) async {
    if (!loadMore || _nextPage != null) {
      String params = _buildQueryParams(queryParams);

      if (isLike) {
        user = await UserService.getUser();
        $print(user?.likedRestaurants);
        if(user?.likedRestaurants?.isNotEmpty ?? false){
          final [_result, _info] = await APIService<Restaurant>(
              fullUrl: user?.likedRestaurants ?? "",
              queryParams: params
          ).list(next: true);
          $print("_result: ${_result.length}");
          _updateRestaurants(_result, _info, isSearch);
        }
        else {
          _updateRestaurants([], {}, isSearch);
        }
      } else {
        final [_result, _info] = await APIService<Restaurant>(
            fullUrl: fullUrl ?? '',
            queryParams: params
        ).list(next: true);
        _updateRestaurants(_result, _info, isSearch);
      }

      update();
    }

    if (!loadMore) {
      await Future.delayed(Duration(milliseconds: TTime.init));
      isLoading.value = false;
    }
  }

  String _buildQueryParams(String? queryParams) {
    List<String> paramList = [];

    if (searchResult != null || queryParams != null || searchTextController.text.isNotEmpty) {
      String name = (isLike) ? "basic_info__name" : "name";
      paramList.add("$name=${searchTextController.text.isNotEmpty ? searchTextController.text : (searchResult ?? queryParams ?? '')}");
    }

    if (category != null) {
      paramList.add("category=$category&dish_category=$category");
    }
    paramList.add("dish_page_size=$dishPageSize");

    return paramList.join('&');
  }

  void _updateRestaurants(List<Restaurant> result, Map<String, dynamic> info, bool isSearch) {
    if (!isSearch) {
      restaurants.addAll(result);
    } else {
      restaurants.value = result;
    }
    _nextPage = info["next"];
  }

  void onSearch() {
    print("searchText: ${searchTextController.text}");
    initializeRestaurants(queryParams: searchTextController.text, isSearch: true);
    print(restaurants.length);
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      initializeRestaurants(loadMore: true, fullUrl: _nextPage);
    }
  }
}