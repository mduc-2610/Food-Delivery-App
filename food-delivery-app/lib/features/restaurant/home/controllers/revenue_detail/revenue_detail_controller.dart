import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/views/splash/splash.dart';
import 'package:food_delivery_app/features/restaurant/home/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RevenueDetailController extends GetxController with GetSingleTickerProviderStateMixin {
  static RevenueDetailController get instance => Get.find();
  final controller = RestaurantHomeController.instance;
  RxList<Delivery> deliveries = <Delivery>[].obs;
  ScrollController scrollController = ScrollController();
  late TabController tabController;
  Rx<bool> isLoadingHistory = true.obs;
  DateTime? selectedDate;
  bool _hasInitializedTab1 = false;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(scrollListener);
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(onTabController);
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      initialize(date: selectedDate);
    }
  }

  void onTabController() {
    if (tabController.index == 1 && deliveries.isEmpty && !_hasInitializedTab1) {
      _hasInitializedTab1 = true;
      initialize(date: selectedDate, reset: true);

    }
  }

  String? nextPage;

  Future<void> initialize({DateTime? date, bool reset = false}) async {
    if (reset) {
      isLoadingHistory.value = true;
      nextPage = null;
      deliveries.value = [];
    }

    String url = nextPage ?? controller.restaurant?.deliveries ?? '';

    if (date != null && nextPage == null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      url += url.contains('?') ? '&date=$formattedDate' : '?date=$formattedDate';
    }

    if (nextPage != null || reset) {
      final [result, info] = await APIService<Delivery>(fullUrl: url).list(next: true);
      deliveries.addAll(result);
      nextPage = info["next"];
    }

    isLoadingHistory.value = false;
    // update();
  }

  void setDate(DateTime? date) {
    selectedDate = date;
    initialize(date: selectedDate, reset: true);
  }
}