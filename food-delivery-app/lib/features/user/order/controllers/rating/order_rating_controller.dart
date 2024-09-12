import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/dialogs/show_confirm_dialog.dart';
import 'package:food_delivery_app/common/widgets/dialogs/show_success_dialog.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/authentication/views/splash/splash.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/models/review/review.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/emojis.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class OrderRatingController extends GetxController with GetSingleTickerProviderStateMixin {
  static OrderRatingController get instance => Get.find();
  /*
  Order: 0
  Deliverer: 1
  Restaurant: 2
  Dish: 4
  */
  final int tabLength = 5;
  late TabController tabController;
  late List<bool> ratedTabs;
  late RxList<int> ratingList;
  Rx<Order?> order = (null as Order?).obs;

  final delivererTitleTextController = TextEditingController();
  final delivererContentTextController = TextEditingController();

  final restaurantTitleTextController = TextEditingController();
  final restaurantContentTextController = TextEditingController();

  RxMap<Dish, dynamic> mapDishTextController = <Dish, dynamic>{}.obs;

  int currentTab = 0;

  String? userId;
  String? orderId;
  String? delivererId;
  String? restaurantId;
  List<Dish> dishes = [];
  User? user;
  Deliverer? deliverer;
  Restaurant? restaurant;
  bool isUpdated = false;


  @override
  void onInit() {
    super.onInit();
    // Initialize late variables
    tabController = TabController(length: tabLength, vsync: this);
    ratedTabs = List.generate(tabLength, (_) => false);
    ratingList = RxList<int>.generate(tabLength, (_) => 0);
    if(Get.arguments != null) {
      order.value = Get.arguments["order"];
    }
    ratedTabs = [
      order.value?.isOrderReviewed ?? false,
      order.value?.isDelivererReviewed ?? false,
      order.value?.isRestaurantReviewed ?? false,
      false,
      order.value?.isDishReviewed ?? false,
    ];
    ratingList.value = [
      order.value?.rating ?? 0,
      order.value?.delivererReview?.rating ?? 0,
      order.value?.restaurantReview?.rating ?? 0,
      0,
      0
    ];

    delivererTitleTextController.text = order.value?.delivererReview?.title ?? "";
    delivererContentTextController.text = order.value?.delivererReview?.content ?? "";

    restaurantTitleTextController.text = order.value?.restaurantReview?.title ?? "";
    restaurantContentTextController.text = order.value?.restaurantReview?.content ?? "";

    int dishReviewsLen = order.value?.dishReviews.length ?? 0;
    int cartDishesLen = order.value?.cart?.cartDishes?.length ?? 0;
    for (int i = 0; i < cartDishesLen; i++) {
      var cartDish = order.value?.cart?.cartDishes[i];
      var dish = cartDish.dish;

      var matchingReview = order.value?.dishReviews.firstWhere(
            (review) => review.dish == dish.id,
        orElse: () => DishReview(dish: dish.id, rating: 0, title: '', content: ''),
      );

      mapDishTextController[dish] = {
        "rating": matchingReview?.rating ?? 0,
        "title": TextEditingController(
          text: matchingReview?.title ?? "",
        ),
        "content": TextEditingController(
          text: matchingReview?.content ?? "",
        ),
      };
    }


    $print(mapDishTextController.length);

    tabController.addListener(_handleTabSelection);
  }

  @override
  void onClose() {
    tabController.removeListener(_handleTabSelection);
    tabController.dispose();
    super.onClose();
  }

  void _handleTabSelection() {
    if (tabController.indexIsChanging) {
      currentTab = tabController.index;
      update();
    }
  }

  void handleRating(int index) {
    ratingList[currentTab] = index + 1;
    setTabRated(currentTab);
    update();
  }

  void handleDishRating(int index, Dish? dish) {
    mapDishTextController[dish]["rating"] = index + 1;
    setTabRated(currentTab);
    update();
  }

  void setTabRated(int index) {
    ratedTabs[index] = true;
    update();
  }

  bool isTabRated(int index) {
    return ratedTabs[index];
  }

  void handleNavigation(bool isSubmit) {
    if (isSubmit) {
      setTabRated(currentTab);
    }

    if (currentTab < tabLength - 1) {
      tabController.animateTo(currentTab + 1);
    } else if (isSubmit) {
      showSuccessDialogs();
    } else {
      Get.back();
    }
  }

  Future<void> handleSubmitReview() async {
    isUpdated = true;
    update();

    if(currentTab == 0) {
      final [statusCode, headers, data] = await APIService<Order>().update(order.value?.id, {
        'rating': ratingList[currentTab]
      },);
      order.value = data;
    }
    else if(currentTab == 1) {
      final [statusCode, headers, data] = await APIService<Order>().update(order.value?.id, Order(
        delivererReview: DelivererReview(
          rating: ratingList[currentTab],
          title: delivererTitleTextController.text,
          content: delivererContentTextController.text
        )
      ).toJson(patch: true), );
      $print("Deliverer review update: ${statusCode} ${headers} ${data?.delivererReview}");
    }
    else if(currentTab == 2) {
      $print(Order(
          restaurantReview: RestaurantReview(
              rating: ratingList[currentTab],
              title: restaurantTitleTextController.text,
              content: restaurantContentTextController.text
          )
      ).toJson(patch: true));
      final [statusCode, headers, data] = await APIService<Order>().update(order.value?.id, Order(
          restaurantReview: RestaurantReview(
              rating: ratingList[currentTab],
              title: restaurantTitleTextController.text,
              content: restaurantContentTextController.text
          )
      ).toJson(patch: true), );
      $print("Restaurant review update: ${statusCode} ${headers} ${data?.restaurantReview}");
    }
    else if (currentTab == 4) {
      List<DishReview> dishReviews = [];
      mapDishTextController.forEach((dish, value) {
        if (value['rating'] != 0 || value['title'].text.isNotEmpty || value['content'].text.isNotEmpty) {
          dishReviews.add(DishReview(
            dish: dish.id,
            rating: value['rating'],
            title: value['title'].text,
            content: value['content'].text,
          ));
        }
      });
      $print(Order(
          dishReviews: dishReviews
      ).dishReviews);

      final [statusCode, headers, data] = await APIService<Order>().update(order.value?.id, Order(
          dishReviews: dishReviews
      ).toJson(patch: true),);
      $print(data);
    }

    if(currentTab != 4) {
      showConfirmDialog(
        Get.context!,
        title: "Thank for your review ${TEmoji.smilingFaceWithHeart}.",
        description: "Your review will help us improve our service.",
        onAccept: () => handleNavigation(true),
        onDecline: () {},
        accept: "Next",
        decline: "Ok",
        declineButtonColor: TColor.secondary
      );
    }
    else {
      showConfirmDialog(
          Get.context!,
          title: "Thank for your review ${TEmoji.smilingFaceWithHeart}.",
          description: "Your review will help us improve our service.",
          onAccept: () => Get.back(result: {
            "isUpdated": isUpdated
          }),
          onDecline: () {},
          accept: "Get back",
          decline: "Ok",
          declineButtonColor: TColor.secondary
      );
    }
  }

  void showSuccessDialogs() {

  }
}