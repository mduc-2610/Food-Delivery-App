import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';

class THardCode {
  THardCode._();

  static List<Map<String, dynamic>> getOrderList() {
    return  [
      {
        'id': 'SP 0023900',
        'image': TImage.hcBurger1,
        'price': 25.20,
        'rating': 4,
        'status': 'Active',
      },
      {
        'id': 'SP 0023512',
        'image': TImage.hcBurger1,
        'price': 40.00,
        'rating': 5,
        'status': 'Completed',
      },
      {
        'id': 'SP 0023502',
        'image': TImage.hcBurger1,
        'price': 85.00,
        'rating': 4,
        'status': 'Completed',
      },
      {
        'id': 'SP 0023450',
        'image': TImage.hcBurger1,
        'price': 20.50,
        'rating': 3,
        'status': 'Cancelled',
      },

      {
        'id': 'SP 0023450',
        'image': TImage.hcBurger1,
        'price': 20.50,
        'rating': 2,
        'status': 'Cancelled',
      },

      {
        'id': 'SP 0023450',
        'image': TImage.hcBurger1,
        'price': 20.50,
        'rating': 2,
        'status': 'Cancelled',
      },

      {
        'id': 'SP 0023450',
        'image': TImage.hcBurger1,
        'price': 20.50,
        'rating': 1,
        'status': 'Cancelled',
      },
      {
        'id': 'SP 0023450',
        'image': TImage.hcBurger1,
        'price': 20.50,
        'rating': 2,
        'status': 'Cancelled',
      },

      {
        'id': 'SP 0023450',
        'image': TImage.hcBurger1,
        'price': 20.50,
        'rating': 2,
        'status': 'Cancelled',
      },

      {
        'id': 'SP 0023450',
        'image': TImage.hcBurger1,
        'price': 20.50,
        'rating': 1,
        'status': 'Cancelled',
      },
    ];
  }

  static List<Map<String, dynamic>> getReviewList() {
    return  [
      {
        'name': 'John Doe',
        'date': '29/03/2024',
        'review':
        'Delicious chicken burger! Loved the crispy chicken and the bun was perfectly toasted. Definitely a new favorite!',
        'rating': 5,
        'type': 'positive'
      },
      {
        'name': 'David',
        'date': '10/04/2024',
        'review':
        'Absolutely delicious! The chicken burger was juicy and flavorful, with just the right amount of seasoning. Highly recommend!',
        'rating': 5,
        'type': 'positive'
      },
      {
        'name': 'Tom',
        'date': '05/04/2024',
        'review':
        'One of the best chicken burgers I’ve ever had! The chicken was tender and the bun was soft. Loved every bite!',
        'rating': 5,
        'type': 'positive'
      },
      {
        'name': 'James',
        'date': '29/03/2024',
        'review':
        'The chicken burger was okay, but it was a bit overcooked for my liking. The toppings were fresh, though.',
        'rating': 3,
        'type': 'negative'
      },
      {
        'name': 'David',
        'date': '10/04/2024',
        'review':
        'Absolutely delicious! The chicken burger was juicy and flavorful, with just the right amount of seasoning. Highly recommend!',
        'rating': 5,
        'type': 'positive'
      },
      {
        'name': 'Tom',
        'date': '05/04/2024',
        'review':
        'One of the best chicken burgers I’ve ever had! The chicken was tender and the bun was soft. Loved every bite!',
        'rating': 5,
        'type': 'positive'
      },
      {
        'name': 'James',
        'date': '29/03/2024',
        'review':
        'The chicken burger was okay, but it was a bit overcooked for my liking. The toppings were fresh, though.',
        'rating': 3,
        'type': 'negative'
      },
      {
        'name': 'James',
        'date': '29/03/2024',
        'review':
        'The chicken burger was okay, but it was a bit overcooked for my liking. The toppings were fresh, though.',
        'rating': 1,
        'type': 'negative'
      },
      {
        'name': 'James',
        'date': '29/03/2024',
        'review':
        'The chicken burger was okay, but it was a bit overcooked for my liking. The toppings were fresh, though.',
        'rating': 2,
        'type': 'negative'
      },
    ];
  }

  static List<Map<String, dynamic>> getNotificationList() {
    return [
      {
        "title": "Get 20% Discount Code",
        "description": "Get discount codes from sharing with friends.",
        "iconStr": TIcon.discount,
        "iconBgColor": TColor.iconBgInfo,
        "time": "12:20 19/05/2024"
      },
      {
        "title": "Get 10% Discount Code",
        "description": "Holiday discount code.",
        "iconStr": TIcon.discount,
        "iconBgColor": TColor.iconBgInfo,
        "time": "10:15 19/05/2024"
      },
      {
        "title": "Order Received",
        "description": "Order #SP_0023900 has been delivered successfully.",
        "iconStr": TIcon.receivedOrder,
        "iconBgColor": TColor.iconBgSuccess,
        "time": "10:15 19/05/2024"
      },
      {
        "title": "Order on the Way",
        "description": "Your delivery driver is on the way with your order.",
        "iconStr": TIcon.onTheWayOrder,
        "iconBgColor": TColor.iconBgSuccess,
        "time": "10:10 19/05/2024"
      },
      {
        "title": "Your Order is Confirmed",
        "description": "Your order #SP_0023900 has been confirmed.",
        "iconStr": TIcon.confirmedOrder,
        "iconBgColor": TColor.iconBgSuccess,
        "time": "09:59 19/05/2024"
      },
      {
        "title": "Order Successful",
        "description": "Order #SP_0023900 has been placed successfully.",
        "iconStr": TIcon.successfulOrder,
        "iconBgColor": TColor.iconBgSuccess,
        "time": "09:56 19/05/2024"
      },
      {
        "title": "Order Cancelled",
        "description": "Order #SP_0023450 has been cancelled.",
        "iconStr": TIcon.cancelledOrder,
        "iconBgColor": TColor.iconBgCancel,
        "time": "22:40 19/05/2024"
      },
      {
        "title": "Account Setup Successful",
        "description": "Congratulations! Your account setup was successful.",
        "iconStr": TIcon.successfulAccountSetup,
        "iconBgColor": TColor.iconBgSuccess,
        "time": "20:15 19/05/2024"
      },
      {
        "title": "Credit Card Connected",
        "description": "Congratulations! Your credit card has been successfully added.",
        "iconStr": TIcon.connectedCreditCard,
        "iconBgColor": TColor.iconBgSuccess,
        "time": "20:00 19/05/2024"
      },
      {
        "title": "Get 5% Discount Code",
        "description": "Discount code for new users.",
        "iconStr": TIcon.discount,
        "iconBgColor": TColor.iconBgInfo,
        "time": "11:10 19/05/2024"
      },
    ];
  }

  static List<Map<String, dynamic>> getCancelList() {
    return [
      {'type': 'Change of mind'},
      {'type': 'Found better price elsewhere'},
      {'type': 'Delivery delay'},
      {'type': 'Incorrect item selected'},
      {'type': 'Duplicate order'},
      {'type': 'Unable to fulfill order'},
      {'type': 'Other reasons'},
    ];
  }

  static List<Map<String, dynamic>> getPromotionList() {
    return [
      {'icon': Icons.share, 'title': 'Share App'},
      {'icon': Icons.person_add, 'title': 'Invite Friends'},
      {'icon': Icons.shopping_cart, 'title': 'Complete Purchases'},
      {'icon': Icons.ondemand_video, 'title': 'Watch Ads'},
      {'icon': Icons.event, 'title': 'Participate in Events'},
      {'icon': Icons.account_circle, 'title': 'Complete Profile'},
      {'icon': Icons.follow_the_signs, 'title': 'Follow Social Media'},
      {'icon': Icons.question_answer, 'title': 'Take Surveys'},
      {'icon': Icons.emoji_events, 'title': 'Achieve Levels'},
      {'icon': Icons.devices_other_rounded, 'title': 'Daily Logins'},
    ];
  }

  static List<Map<String, dynamic>> getPaymentList() {
    return [
      {'icon': Icons.money, 'name': 'Cash'},
      {'icon': Icons.account_balance_wallet, 'name': 'PayPal'},
      {'icon': Icons.account_balance_wallet, 'name': 'Google Pay'},
      {'icon': Icons.account_balance_wallet, 'name': 'Apple Pay'},
      {'icon': Icons.credit_card, 'name': '**** **** **** 0895'},
      {'icon': Icons.credit_card, 'name': '**** **** **** 2259'},
    ];
  }

  static List<Map<String, dynamic>> getMessageList() {
    return [
      {
        "title": "Get 20% Discount Code",
        "description": "Get discount codes from sharing with friends.",
        "iconStr": TIcon.discount,
        "iconBgColor": TColor.iconBgInfo,
        "time": "12:20 19/05/2024"
      },
      {
        "title": "Get 10% Discount Code",
        "description": "Holiday discount code.",
        "iconStr": TIcon.discount,
        "iconBgColor": TColor.iconBgInfo,
        "time": "10:15 19/05/2024"
      },
      {
        "title": "Order Received",
        "description": "Order #SP_0023900 has been delivered successfully.",
        "iconStr": TIcon.receivedOrder,
        "iconBgColor": TColor.iconBgSuccess,
        "time": "10:15 19/05/2024"
      },
      {
        "title": "Order on the Way",
        "description": "Your delivery driver is on the way with your order.",
        "iconStr": TIcon.onTheWayOrder,
        "iconBgColor": TColor.iconBgSuccess,
        "time": "10:10 19/05/2024"
      },
      {
        "title": "Your Order is Confirmed",
        "description": "Your order #SP_0023900 has been confirmed.",
        "iconStr": TIcon.confirmedOrder,
        "iconBgColor": TColor.iconBgSuccess,
        "time": "09:59 19/05/2024"
      },
      {
        "title": "Order Successful",
        "description": "Order #SP_0023900 has been placed successfully.",
        "iconStr": TIcon.successfulOrder,
        "iconBgColor": TColor.iconBgSuccess,
        "time": "09:56 19/05/2024"
      },
      {
        "title": "Order Cancelled",
        "description": "Order #SP_0023450 has been cancelled.",
        "iconStr": TIcon.cancelledOrder,
        "iconBgColor": TColor.iconBgCancel,
        "time": "22:40 19/05/2024"
      },
      {
        "title": "Account Setup Successful",
        "description": "Congratulations! Your account setup was successful.",
        "iconStr": TIcon.successfulAccountSetup,
        "iconBgColor": TColor.iconBgSuccess,
        "time": "20:15 19/05/2024"
      },
      {
        "title": "Credit Card Connected",
        "description": "Congratulations! Your credit card has been successfully added.",
        "iconStr": TIcon.connectedCreditCard,
        "iconBgColor": TColor.iconBgSuccess,
        "time": "20:00 19/05/2024"
      },
      {
        "title": "Get 5% Discount Code",
        "description": "Discount code for new users.",
        "iconStr": TIcon.discount,
        "iconBgColor": TColor.iconBgInfo,
        "time": "11:10 19/05/2024"
      },
    ];
  }
}