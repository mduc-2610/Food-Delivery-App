import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/user/food/controllers/detail/food_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/models/review/review.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class ReviewController<T> extends GetxController with SingleGetTickerProviderMixin {
  static ReviewController get instance => Get.find();

  T? item;
  String? reviewsUrl;
  Rx<int> currentTabIndex = 0.obs;
  var reviews = <dynamic>[].obs;
  Rx<bool> isPageLoading = true.obs;
  Rx<bool> isReviewLoading = false.obs;
  late TabController tabController;
  final List<String> tabTypes = ['All', 'Positive', 'Negative', '5', '4', '3', '2', '1'];
  final scrollController = ScrollController();

  void initialize({T? item, String? reviewsUrl}) {
    this.item = item;
    this.reviewsUrl = reviewsUrl;
    tabController = TabController(length: tabTypes.length, vsync: this);
    tabController.addListener(_handleTabSelection);
    scrollController.addListener(_scrollListener);
    initializeReviews();
    $print("scroll");
    $print(reviewsUrl);
  }

  void onTapTab(int index) {
    currentTabIndex.value = index;
    if(reviewsUrl != null) {
      initializeReviews(filter: tabTypes[index]);
    }
  }

  void _handleTabSelection() {
    if (tabController.indexIsChanging) {
      print(tabController.index);
      update();
    }
  }

  String? _nextPage;
  Future<void> initializeReviews({String filter = 'All'}) async {
    isReviewLoading.value = true;
    if(reviewsUrl != null) {
      final [_result, _info] = await APIService<DishReview>(fullUrl: reviewsUrl!, queryParams: "star_filter=${filter.toLowerCase()}").list(next: true);
      reviews.value = _result;
      _nextPage = _info["next"];
    }
    await Future.delayed(Duration(milliseconds: TTime.init));
    isPageLoading.value = false;
    isReviewLoading.value = false;
    update();
  }

  Future<void> loadMoreReviews({String filter = 'All'}) async {
    if(_nextPage != null && reviewsUrl != null) {
      final [_result, _info] = await APIService<DishReview>(fullUrl: _nextPage!).list(next: true);
      reviews.addAll(_result);
      reviews.refresh();
      _nextPage = _info["next"];
    }
  }

  void _scrollListener() {
    if (reviewsUrl != null && scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadMoreReviews();
    }

  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    tabController.removeListener(_handleTabSelection);
    tabController.dispose();
    super.onClose();
  }
}

class FoodDetailReviewController extends ReviewController<Dish> {
  static FoodDetailReviewController get instance => Get.find();
  final _foodDetailController = FoodDetailController.instance;

  @override
  void onInit() {
    super.onInit();
    initialize(
      item: _foodDetailController.dish!,
      reviewsUrl: _foodDetailController.dish!.dishReviews!,
    );
  }
}

class RestaurantDetailReviewController extends ReviewController<Restaurant> {
  static RestaurantDetailReviewController get instance => Get.find();
  final _restaurantDetailController = RestaurantDetailController.instance;

  @override
  void onInit() {
    super.onInit();
    initialize(
      item: _restaurantDetailController.restaurant!,
      reviewsUrl: _restaurantDetailController.restaurant!.restaurantReviews!,
    );
  }
}

