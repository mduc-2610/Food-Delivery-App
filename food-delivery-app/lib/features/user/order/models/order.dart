import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/user/food/models/review/review.dart';
import 'package:food_delivery_app/features/user/order/models/cart.dart';
import 'package:food_delivery_app/features/user/order/models/promotion.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';

@reflector
@jsonSerializable
class Order {
  final String? id;
  final dynamic cart;
  final dynamic deliveryAddress;
  final dynamic cancellation;
  final String? paymentMethod;
  final String? promotion;
  final double deliveryFee;
  final double discount;
  double total;
  double totalPrice;
  final int? rating;
  final String? status;
  final bool? isReviewed;
  final bool? isDelivererReviewed;
  final bool? isDishReviewed;
  final bool? isOrderReviewed;
  final bool? isRestaurantReviewed;
  dynamic delivererReview;
  dynamic restaurantReview;
  final Deliverer? deliverer;
  final Restaurant? restaurant;
  List<DishReview> dishReviews;
  List<RestaurantPromotion> restaurantPromotions;

  Order({
    this.id,
    this.cart,
    this.deliveryAddress,
    this.paymentMethod,
    this.cancellation,
    this.promotion,
    this.deliveryFee = 0,
    this.discount = 0,
    this.total = 0,
    this.rating,
    this.totalPrice = 0,
    this.status,
    this.isReviewed,
    this.isDelivererReviewed,
    this.isDishReviewed,
    this.isOrderReviewed,
    this.isRestaurantReviewed,
    this.delivererReview,
    this.restaurantReview,
    this.deliverer,
    this.restaurant,
    this.dishReviews = const [],
    this.restaurantPromotions = const [],
  });

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cart = json['cart'] == null || json['cart'] is String || json['cart'] is List ? json['cart'] : RestaurantCart.fromJson(json['cart']),
        deliveryAddress = json['delivery_address'] == null || json['delivery_address'] is String ? json['delivery_address'] : UserLocation.fromJson(json['delivery_address']),
        cancellation = json['cancellation'] == null || json['cancellation'] is String ? json['cancellation'] : OrderCancellation.fromJson(json['cancellation']),
        paymentMethod = json['payment_method'],
        promotion = json['promotion'],
        deliveryFee = THelperFunction.formatDouble(json['delivery_fee']),
        discount = THelperFunction.formatDouble(json['discount']),
        totalPrice = THelperFunction.formatDouble(json['total_price']),
        total = THelperFunction.formatDouble(json['total']),
        rating = json['rating'],
        status = json['status'],
        isReviewed = json['is_reviewed'],
        isDelivererReviewed = json['is_deliverer_reviewed'],
        isDishReviewed = json['is_dish_reviewed'],
        isOrderReviewed = json['is_order_reviewed'],
        isRestaurantReviewed = json['is_restaurant_reviewed'],
        restaurant = json['restaurant'] == null || json['restaurant'] is String ? json['restaurant'] : Restaurant.fromJson(json['restaurant']),
        deliverer = json['deliverer'] == null || json['deliverer'] is String ? json['deliverer'] : Deliverer.fromJson(json['deliverer']),
        dishReviews = (json['dish_reviews'] as List<dynamic>?)?.map((instance) => DishReview.fromJson(instance)).toList() ?? [],
        delivererReview = json['deliverer_review'] == null || json['deliverer_review'] is String ? json['deliverer_review'] : DelivererReview.fromJson(json['deliverer_review']),
        restaurantReview = json['restaurant_review'] == null || json['restaurant_review'] is String ? json['restaurant_review'] : RestaurantReview.fromJson(json['restaurant_review']),
        restaurantPromotions = json['restaurant_promotions'] != null ?
          json['restaurant_promotions'] is String ? json['restaurant_promotions'] :
          (json['restaurant_promotions'] as List).map((instance) => RestaurantPromotion.fromJson(instance)).toList() : []
  ;

  Map<String, dynamic> toJson({bool patch = false}) {
    final Map<String, dynamic> data = {
      'id': id,
      'cart': cart is String ? cart : cart?.toJson(),
      'delivery_address': deliveryAddress,
      'payment_method': paymentMethod,
      'promotion': promotion,
      'delivery_fee': deliveryFee,
      'discount': discount,
      'total': total,
      'status': status,
      'rating': rating,
      'deliverer_review': delivererReview is String ? delivererReview : delivererReview?.toJson(patch: patch),
      'restaurant_review': restaurantReview is String ? restaurantReview : restaurantReview?.toJson(patch: patch),
      'dish_reviews': dishReviews?.map((dish) => dish.toJson(patch: patch)).toList() ?? [],
    };

    if (patch) {
      data.removeWhere((key, value) => value == null);
    }

    return data;
  }


  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}

@reflector
@jsonSerializable
class OrderCancellation {
  final dynamic order;
  final dynamic user;
  final dynamic restaurant;
  final String? reason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isAccepted;

  OrderCancellation({
    this.order,
    this.user,
    this.restaurant,
    this.reason,
    this.createdAt,
    this.updatedAt,
    this.isAccepted = false,
  });

  OrderCancellation.fromJson(Map<String, dynamic> json)
    : order = json['order'] == null || json['order'] is String || json['order'] is List ? json['order']  : Order.fromJson(json['order']),
      user = json['user'] == null || json['user'] is String || json['user'] is List ? json['user']  : User.fromJson(json['user']),
      restaurant = json['restaurant'] == null || json['restaurant'] is String || json['restaurant'] is List? json['restaurant'] : Restaurant.fromJson(json['restaurant']),
      reason = json['reason'],
      createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      isAccepted = json['is_accepted'] ?? false
  ;

  Map<String, dynamic> toJson() {
    return {
      'order': order is String ? order : order?.id,
      'user': user is String ? user : user?.id,
      'restaurant': restaurant is String ? restaurant : restaurant?.id,
      'reason': reason,
    };
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}