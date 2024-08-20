
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/common/controllers/bars/filter_bar_controller.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  static OrderHistoryController get instance => Get.find();

  late FilterBarController filterBarController;
  User? user;
  var restaurantCarts = <RestaurantCart>[].obs;
  Rx<bool> isLoading = true.obs;
  final scrollController = ScrollController();

  String _filterDefault = "All";
  @override
  void onInit() {
    super.onInit();
    filterBarController = Get.put(FilterBarController(_filterDefault), tag: user?.id);
    scrollController.addListener(_scrollListener);
    initializeUser();
  }

  void _scrollListener() {
    if(_nextPage != null && scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      fetchFilterOrder("", loadMore: true);
    }
  }

  Future<void> initializeUser() async {
    user = await UserService.getUser();
    await fetchFilterOrder(_filterDefault);
  }

  String? _nextPage;
  Future<void> fetchFilterOrder(String filter, { bool loadMore = false }) async {
    if(!loadMore) isLoading.value = true;
    if(_nextPage != null || !loadMore) {
      final [_result, _info] = await APIService<RestaurantCart>(fullUrl: (loadMore) ? _nextPage ?? "" : user?.restaurantCarts ?? "", queryParams: (loadMore) ? "" : "star_filter=${filter}").list(next: true);
      if(!loadMore) restaurantCarts.value = _result;
      else restaurantCarts.addAll(_result);
      _nextPage = _info["next"];
    }
    if(!loadMore) {
      await Future.delayed(Duration(milliseconds: TTime.init));
      isLoading.value = false;
    }
    update();
  }

}