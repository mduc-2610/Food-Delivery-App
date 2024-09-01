
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/deliverer_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/data/socket_services/order_socket_service.dart';
import 'package:food_delivery_app/data/socket_services/socket_service.dart';
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
  var isOccupied = true.obs;
  User? user;
  Deliverer? deliverer;
  List<Delivery> deliveries = [];
  RxList<DeliveryRequest> deliveryRequests = <DeliveryRequest>[].obs;
  SocketService? delivererSocket;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    initialize();
  }

  @override
  void onClose() {
    delivererSocket?.disconnect();
  }

  void _scrollListener() {
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      $print(_nextPage);
      initialize(loadMore: true);
    }
  }

  String? _nextPage, _nextPage2;
  Future<void> initialize({ bool loadMore = false }) async {
    deliverer = await DelivererService.getDeliverer();
    isOccupied.value = deliverer?.isOccupied ?? false;
    delivererSocket = SocketService<Deliverer>();
    delivererSocket?.connect(id: deliverer?.id);
    if(_nextPage != null || !loadMore) {
      var [_result, _info] = await APIService<Delivery>(fullUrl: _nextPage ?? deliverer?.deliveries ?? '').list(next: true);
      deliveries.addAll(_result);
      _nextPage = _info["next"];
      [_result, _info] = await APIService<DeliveryRequest>(fullUrl: _nextPage2 ?? deliverer?.requests ?? '').list(next: true);
      deliveryRequests.addAll(_result);
      _nextPage2 = _info["next"];
    }
    if(!loadMore) {
      await Future.delayed(Duration(milliseconds: TTime.init));
    }
    isLoading.value = false;
    update();
  }
}