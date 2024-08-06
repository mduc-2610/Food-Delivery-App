import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/user/food/controllers/detail/food_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/models/review/review.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class FoodDetailReviewController extends GetxController with SingleGetTickerProviderMixin {
  static FoodDetailReviewController get instance => Get.find();

  final _foodDetailController = FoodDetailController.instance;
  Dish? dish;
  Rx<int> currentTabIndex = 0.obs;
  List<DishReview> reviews = [];
  Rx<bool> isPageLoading = true.obs;
  Rx<bool> isReviewLoading = false.obs;
  late TabController tabController;
  final List<String> tabTypes = ['All', 'Positive', 'Negative', '5', '4', '3', '2', '1'];

  @override
  void onInit() {
    super.onInit();
    dish = _foodDetailController.dish;
    tabController = TabController(length: tabTypes.length, vsync: this);
    tabController.addListener(_handleTabSelection);
    initializeDishReview();
  }

  void onTapTab(index) {
    currentTabIndex.value = index;
    initializeDishReview(filter: tabTypes[index]);
  }

  void _handleTabSelection() {
    if (tabController.indexIsChanging) {
      print(tabController.index);
      update();
    }
  }

  Future<void> initializeDishReview({String filter = 'All'}) async {
    isReviewLoading.value = true;
    String reviewsUrl = dish?.dishReviews ?? "";
    $print(reviewsUrl);
    reviews = await APIService<DishReview>(fullUrl: reviewsUrl, queryParams: "star_filter=${filter.toLowerCase()}").list();
    await Future.delayed(Duration(milliseconds: TTime.init));
    isPageLoading.value = false;
    isReviewLoading.value = false;
    update();
  }

  @override
  void onClose() {
    tabController.removeListener(_handleTabSelection);
    tabController.dispose();
    super.onClose();
  }
}
