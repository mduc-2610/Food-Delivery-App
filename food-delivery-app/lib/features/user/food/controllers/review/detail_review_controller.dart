import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/deliverer/home/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/user/food/controllers/detail/food_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/controllers/home/home_controller.dart';
import 'package:food_delivery_app/features/user/food/controllers/restaurant/restaurant_detail_controller.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/models/review/review.dart';
import 'package:food_delivery_app/features/user/food/models/review/review_like.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class ReviewController<T, R extends Review> extends GetxController with SingleGetTickerProviderMixin {
  static ReviewController get instance => Get.find();

  T? item;
  User? user;
  String? reviewsUrl;
  Rx<int> currentTabIndex = 0.obs;
  var reviews = <R>[].obs; // Now strongly typed
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
    print("scroll");
    print(reviewsUrl);
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
    if(user == null) {
      user = await UserService.getUser();
    }

    if(reviewsUrl != null) {
      final [_result, _info] = await APIService<R>(
        fullUrl: reviewsUrl!,
        queryParams: "star_filter=${filter.toLowerCase()}",
      ).list(next: true);
      reviews.value = _result.cast<R>();
      _nextPage = _info["next"];
    }

    await Future.delayed(Duration(milliseconds: TTime.init));
    isPageLoading.value = false;
    isReviewLoading.value = false;
    update();
  }

  Future<void> loadMoreReviews({String filter = 'All'}) async {
    if(_nextPage != null && reviewsUrl != null) {
      final [_result, _info] = await APIService<R>(
        fullUrl: _nextPage!,
      ).list(next: true);
      reviews.addAll(_result.cast<R>());
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

  String getEndpoint() {
    if(T == Deliverer) {
      return "review/deliverer-review-like";
    }
    else if(T == Restaurant) {
      return "review/restaurant-review-like";
    }
    else if(T == Delivery) {
      return "review/delivery-review-like";
    }
    return "review/dish-review-like";
  }

  Future<dynamic> callCreateReview(like) async {
    if(T == Restaurant) {
      return await APIService<RestaurantReviewLike>().create(like.toJson());
    }
    else if (T == Deliverer) {
      return await APIService<DelivererReviewLike>().create(like.toJson());
    }
    else if(T == Delivery) {
      return await APIService<DeliveryReviewLike>().create(like.toJson());
    }
    return await APIService<DishReviewLike>().create(like.toJson());
  }

  Future<dynamic> callDeleteReview(like) async {
    if(T == Restaurant) {
      return await APIService<RestaurantReviewLike>().delete(like.id!);
    }
    else if (T == Deliverer) {
      return await APIService<DelivererReviewLike>().delete(like.id!);
    }
    else if(T == Delivery) {
      return await APIService<DeliveryReviewLike>().delete(like.id!);
    }
    return await APIService<DishReviewLike>().delete(like.id!);
  }

  Future<dynamic> callListReview(user, review) async {
    if(T == Restaurant) {
      return await APIService<RestaurantReviewLike>(
        queryParams: 'user=${user.id}&review=${review.id}',
      ).list();
    }
    else if (T == Deliverer) {
      return await APIService<DelivererReviewLike>(
        queryParams: 'user=${user.id}&review=${review.id}',
      ).list();
    }
    else if(T == Delivery) {
      return await APIService<DeliveryReviewLike>(
        queryParams: 'user=${user.id}&review=${review.id}',
      ).list();
    }
    return await APIService<DishReviewLike>(
      queryParams: 'user=${user.id}&review=${review.id}',
    ).list();
  }

  Future<void> toggleLike(R review) async {
    if (review.isLiked.value) {
      await unlikeReview(review);
    } else {
      await likeReview(review);
    }
    update();
  }

  Future<void> likeReview(R review) async {
    try {
      final currentUser = user;
      if (currentUser == null || currentUser.id == null) {
        // Get.snackbar('Error', 'User not found.');
        return;
      }

      final like = ReviewLike(
        review: review.id,
        user: currentUser.id,
      );

      $print("${getEndpoint()} : $like");
      final createdLike = await callCreateReview(like);
      if (createdLike != null) {
        review.isLiked.value = true;
        review.totalLikes.value += 1;
        // Get.snackbar('Success', 'You have liked this review.');
      } else {
        // Get.snackbar('Error', 'Failed to like the review.');
      }
    } catch (e) {
      // Get.snackbar('Error', 'An error occurred while liking the review.');
    }
  }

  Future<void> unlikeReview(R review) async {
    try {
      final currentUser = user;
      if (currentUser == null || currentUser.id == null) {
        // Get.snackbar('Error', 'User not found.');
        return;
      }
      final likes = await callListReview(user, review);
      $print(likes);
      if (likes.isNotEmpty) {
        final like = likes.first;
        final success = await callDeleteReview(like);
        if (success) {
          review.isLiked.value = false;
          review.totalLikes.value -= 1;
          // Get.snackbar('Success', 'You have unliked this review.');
        } else {
          // Get.snackbar('Error', 'Failed to unlike the review.');
        }
      } else {
        // Get.snackbar('Error', 'Like entry not found.');
      }
    } catch (e) {
      // Get.snackbar('Error', 'An error occurred while unliking the review.');
    }
  }
}

class FoodDetailReviewController extends ReviewController<Dish, DishReview> {
  static FoodDetailReviewController get instance => Get.find();

  final Dish item;

  FoodDetailReviewController({required this.item});

  @override
  void onInit() {
    super.onInit();
    initialize(
      item: item,
      reviewsUrl: item.dishReviews!,
    );
  }
}

class RestaurantDetailReviewController extends ReviewController<Restaurant, RestaurantReview> {
  static RestaurantDetailReviewController get instance => Get.find();

  final Restaurant item;

  RestaurantDetailReviewController({required this.item});

  @override
  void onInit() {
    super.onInit();
    initialize(
      item: item,
      reviewsUrl: item.restaurantReviews!,
    );
  }
}

class DelivererDetailReviewController extends ReviewController<Deliverer, DelivererReview> {
  static DelivererDetailReviewController get instance => Get.find();

  final Deliverer? item;

  DelivererDetailReviewController({required this.item});

  @override
  void onInit() {
    super.onInit();
    initialize(
      item: item,
      reviewsUrl: item?.delivererReviews!,
    );
  }
}
