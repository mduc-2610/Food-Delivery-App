import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/features/user/order/models/promotion.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderPromotionController extends GetxController {
  static OrderPromotionController get instance => Get.find();

  Rx<bool> isLoading = true.obs;
  Order? order;
  String? restaurantId;
  Restaurant? restaurant;
  RxList<RestaurantPromotion> promotions = <RestaurantPromotion>[].obs;
  RxList<RestaurantPromotion> shippingPromotions = <RestaurantPromotion>[].obs;
  RxList<RestaurantPromotion> orderPromotions = <RestaurantPromotion>[].obs;
  ScrollController scrollController = ScrollController();
  late final RestaurantDetailController? restaurantDetailController;

  RxBool seeMoreShipping = false.obs;
  RxBool seeMoreOrder = false.obs;

  Rx<RestaurantPromotion?> chosenShippingPromotion = Rx<RestaurantPromotion?>(null);
  Rx<RestaurantPromotion?> chosenOrderPromotion = Rx<RestaurantPromotion?>(null);

  OrderPromotionController({
    this.order,
    this.restaurantId,
    this.restaurant,
  });

  @override
  void onInit() {
    super.onInit();
    try {
      restaurantDetailController = RestaurantDetailController.instance;
      initialize();
    } catch (e) {
      restaurantDetailController = null;
    }
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
        (seeMoreOrder.value || seeMoreShipping.value)) {
      loadPromotions();
    }
  }

  String? nextPage;

  Future<void> initialize() async {
    isLoading.value = true;
    restaurant = restaurant ?? (restaurantId != null || restaurantDetailController?.restaurantId != null
        ? await APIService<Restaurant>().retrieve(restaurantId ?? restaurantDetailController?.restaurantId ?? '')
        : null);
    await loadPromotions(next: true);
    await Future.delayed(Duration(milliseconds: TTime.init));
    isLoading.value = false;
  }

  Future<void> loadPromotions({bool next = false}) async {
    if (nextPage != null || next) {
      String url = nextPage ?? "${restaurant?.promotions}?need_query=True&order=${order?.id}";
      final [_result, info] = await APIService<RestaurantPromotion>(fullUrl: url, queryParams: "").list(next: true);
      promotions.addAll(_result);

      shippingPromotions.value = promotions.where((promotion) => promotion.promoType == "Shipping").toList();
      chosenShippingPromotion.value = chosenShippingPromotion.value
          ?? shippingPromotions.firstWhereOrNull(
                  (promotion) => promotion.isChosen == true,
          );

      orderPromotions.value = promotions.where((promotion) => promotion.promoType == "Order").toList();
      chosenOrderPromotion.value = chosenOrderPromotion.value
          ?? orderPromotions.firstWhereOrNull(
                (promotion) => promotion.isChosen == true,
          );

      nextPage = info["next"];
      print(info["next"]);
    }
  }

  void toggleSeeMoreShipping() {
    seeMoreShipping.value = !seeMoreShipping.value;
  }

  void toggleSeeMoreOrder() {
    seeMoreOrder.value = !seeMoreOrder.value;
  }

  void chooseShippingPromotion(RestaurantPromotion? promotion) {
    if (chosenShippingPromotion.value == promotion) {
      chosenShippingPromotion.value = null;
    } else {
      chosenShippingPromotion.value = promotion;
    }
  }

  void chooseOrderPromotion(RestaurantPromotion? promotion) {
    if (chosenOrderPromotion.value == promotion) {
      chosenOrderPromotion.value = null;
    } else {
      chosenOrderPromotion.value = promotion;
    }
  }

  Future<void> handleApplyPromotion() async {
    $print("APPLY");
    List<String> chosenPromotionIds = [];
    if (chosenShippingPromotion.value != null) {
      chosenPromotionIds.add(chosenShippingPromotion.value?.id ?? '');
    }
    if (chosenOrderPromotion.value != null) {
      chosenPromotionIds.add(chosenOrderPromotion.value?.id ?? '');
    }

    final [statusCode, headers, data] = await APIService<Order>().update(order?.id, {
      "restaurant_promotions": chosenPromotionIds,
    });

    if (statusCode == 200) {
      order = data;
      $print("STATS: {"
          "total_price: ${order?.totalPrice}"
          "delivery_fee: ${order?.deliveryFee}"
          "discount: ${order?.discount}"
          "total: ${order?.total}"
      );
      Get.back(result: {
        "order": order,
        "chosenPromotionIds": chosenPromotionIds
      });
    } else {
      // Handle error
      $print("Error applying promotions: $statusCode");
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}