
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/features/authentication/models/account/profile.dart';
import 'package:food_delivery_app/features/authentication/models/account/setting.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/auth/login_password.dart';
import 'package:food_delivery_app/features/authentication/models/auth/send_otp.dart';
import 'package:food_delivery_app/features/authentication/models/auth/set_password.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/features/authentication/models/auth/verify_otp.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/address.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/basic_info.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/driver_license.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/emergency_contact.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/operation_info.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/other_info.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/residency_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/basic_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/detail_info.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/menu_delivery.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/operating_hour.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/representative.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/notification/models/message.dart';
import 'package:food_delivery_app/features/notification/models/user_notification.dart';
import 'package:food_delivery_app/features/user/food/models/food/addition.dart';
import 'package:food_delivery_app/features/user/food/models/food/category.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish.dart';
import 'package:food_delivery_app/features/user/food/models/food/dish_like.dart';
import 'package:food_delivery_app/features/user/food/models/review/review.dart';
import 'package:food_delivery_app/features/user/food/models/review/review_like.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/features/user/order/models/order.dart';
import 'package:food_delivery_app/features/user/order/models/owned_promotion.dart';
import 'package:food_delivery_app/features/user/order/models/promotion.dart';
import 'package:food_delivery_app/features/user/social/models/comment.dart';
import 'package:food_delivery_app/features/user/social/models/image.dart';
import 'package:food_delivery_app/features/user/social/models/like.dart';
import 'package:food_delivery_app/features/user/social/models/post.dart';

class APIConstant {
  static const String tSecretAPIKey = "";
  // static const baseUrl = 'http://10.0.2.2:8000/api';
  static const baseUrl = 'http://192.168.1.8:8000/api'; // VANSAU
  // static const baseUrl = 'http://192.168.0.107:8000/api'; // Tenda


  static String? getEndpointFor<T>() {
    switch (T) {
      ///AUTHENTICATION
      case LoginPassword:
        return 'account/user/login-password';
      case SendOTP:
        return 'account/user/send-otp';
      case SetPassword:
        return 'account/user/set-password';
      case Token:
        return 'account/user/token';
      case VerifyOTP:
        return 'account/user/verify-otp';

      ///USER
      case User:
        return 'account/user';
      case UserProfile:
        return 'account/profile';
      case UserSetting:
        return 'account/setting';
      case UserSecuritySetting:
        return 'account/security-setting';
      case Me:
        return 'account/user/me';

      ///RESTAURANT
      case Restaurant:
        return 'restaurant/restaurant';
      case RestaurantBasicInfo:
        return 'restaurant/basic-info';
      case RestaurantDetailInfo:
        return 'restaurant/detail-info';
      case RestaurantMenuDelivery:
        return 'restaurant/menu-delivery';
      case RestaurantOperatingHour:
        return 'restaurant/operating-hour';
      case RestaurantRepresentative:
        return 'restaurant/representative';

      ///DELIVERER
      case Deliverer:
        return 'deliverer/deliverer';
      case DelivererAddress:
        return 'deliverer/address';
      case DelivererBasicInfo:
        return 'deliverer/basic-info';
      case DelivererDriverLicense:
        return 'deliverer/driver-license';
      case DelivererEmergencyContact:
        return 'deliverer/emergency-contact';
      case DelivererOperationInfo:
        return 'deliverer/operation-info';
      case DelivererOtherInfo:
        return 'deliverer/other-info';
      case DelivererResidencyInfo:
        return 'deliverer/residency-info';

        ///NOTIFICATION
      case Message:
        return 'notification/message';
      case ImageMessage:
        return 'notification/image-message';
      case AudioMessage:
        return 'notification/audio-message';
      case LocationMessage:
        return 'notification/location-message';
      case Notification:
        return 'notification/notification';
      case UserNotification:
        return 'notification/user-notification';

      ///REVIEW
      case DishReview:
        return 'review/dish-review';
      case DelivererReview:
        return 'review/deliverer-review';
      case RestaurantReview:
        return 'review/restaurant-review';
      case DeliveryReview:
        return 'review/delivery-review';
      case DishReviewLike:
        return 'review/dish-review-like';
      case RestaurantReviewLike:
        return 'review/restaurant-review-like';
      case DelivererReviewLike:
        return 'review/deliverer-review-like';
      case DeliveryReviewLike:
        return 'review/delivery-review-like';

      ///ORDER
      case Cart:
        return 'order/cart';
      case RestaurantCart:
        return 'order/restaurant-cart';
      case RestaurantCartDish:
        return 'order/restaurant-cart-dish';
      case Delivery:
        return 'order/delivery';
      case Order:
        return 'order/order';
      case OrderPromotion:
        return 'order/order-promotion';
      case RestaurantPromotion:
        return 'order/restaurant-promotion';
      case UserPromotion:
        return 'order/user-promotion';
      case Promotion:
        return 'order/promotion';
      case ActivityPromotion:
        return 'order/activity-promotion';

      ///SOCIAL
      case Post:
        return 'social/post';
      case PostLike:
        return 'social/post-like';
      case PostImage:
        return 'social/post-image';
      case Comment:
        return 'social/comment';
      case CommentLike:
        return 'social/comment-like';
      case CommentImage:
        return 'social/comment-image';

      ///FOOD
      case DishAdditionalOption:
        return 'food/dish-option';
      case DishSizeOption:
        return 'food/dish-size';
      case DishCategory:
        return 'food/dish-category';
      case DishLike:
        return 'food/dish-like';
      case Dish:
        return 'food/dish';
      default:
        return null;
    }
  }
}
