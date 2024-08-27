
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/deliverer_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class DelivererHomeController extends GetxController {
  static DelivererHomeController get instance => Get.find();

  final scrollController = ScrollController();
  var isLoading = true.obs;
  User? user;
  Deliverer? deliverer;
  List<Delivery> deliveries = [];

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    initialize();
  }

  void _scrollListener() {
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      $print(_nextPage);
      initialize(loadMore: true);
    }
  }

  String? _nextPage;
  Future<void> initialize({ bool loadMore = false }) async {
    deliverer = await DelivererService.getDeliverer();
    if(_nextPage != null || !loadMore) {
      final [_result, _info] = await APIService<Delivery>(fullUrl: deliverer?.deliveries ?? '').list(next: true);
      deliveries.addAll(_result);
      _nextPage = _info["next"];
    }
    if(!loadMore) {
      await Future.delayed(Duration(milliseconds: TTime.init));
    }
    isLoading.value = false;
    update();
  }
}