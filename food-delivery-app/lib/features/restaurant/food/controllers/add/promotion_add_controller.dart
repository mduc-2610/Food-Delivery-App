import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/restaurant_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/user/order/models/promotion.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PromotionAddController extends GetxController {
  static PromotionAddController get instance => Get.find();

  final formKey = GlobalKey<FormState>();
  String? promotionId;
  RestaurantPromotion? promotion;
  Restaurant? restaurant;

  Rx<bool> isLoading = true.obs;

  final promoType = ''.obs;
  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().obs;

  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final discountPercentageController = TextEditingController();
  final discountAmountController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  void setStartDate(DateTime? date) {
    startDate.value = date ?? DateTime.now();
    startDateController.text = DateFormat("dd/MM/yyyy").format(startDate.value);
  }

  void setEndDate(DateTime? date) {
    endDate.value = date ?? DateTime.now();
    endDateController.text = DateFormat("dd/MM/yyyy").format(endDate.value);
  }

  PromotionAddController({ this.promotionId });

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null) {
      promotionId = Get.arguments['id'];
    }
    initialize();
  }

  Future<void> initialize() async {
    isLoading.value = true;
    restaurant = restaurant ?? await RestaurantService.getRestaurant();
    if(promotionId != null) {
      promotion = await APIService<RestaurantPromotion>().retrieve(promotionId ?? '');
      assignPromotionData();
    }
    await Future.delayed(Duration(milliseconds: 500));
    isLoading.value = false;
    update();
  }

  void assignPromotionData() {
    if (promotion != null) {
      codeController.text = promotion?.code ?? '';
      nameController.text = promotion?.name ?? '';
      descriptionController.text = promotion?.description ?? '';
      promoType.value = promotion?.promoType ?? 'Percentage';
      discountPercentageController.text = (promotion?.discountPercentage?.toString() ?? '0.0') + "%";
      discountAmountController.text = promotion?.discountAmount?.toString() ?? '0.0';
      startDateController.text = THelperFunction.formatDate(promotion?.startDate, format: "dd/MM/yyyy");
      endDateController.text = THelperFunction.formatDate(promotion?.endDate, format: "dd/MM/yyyy");
    }
  }

  void setPromoType(String? value) => promoType.value = value ?? 'Percentage';

  Future<void> onCallApi() async {
    final promotionData = RestaurantPromotion(
      code: codeController.text,
      name: nameController.text,
      description: descriptionController.text,
      promoType: promoType.value,
      discountPercentage: THelperFunction.formatDouble(discountPercentageController.text),
      discountAmount: THelperFunction.formatDouble(discountAmountController.text),
      startDate: startDate.value,
      endDate: endDate.value,
      restaurant: restaurant?.id,
    );

    $print(promotionData?.toJson());


    if (promotion != null) {
      final [statusCode, headers, data] = await APIService<RestaurantPromotion>().update(promotion?.id ?? "", promotionData);
      $print([statusCode, headers, data]);
    } else {
      final [statusCode, headers, data] = await APIService<RestaurantPromotion>().create(promotionData);
      $print([statusCode, headers, data]);
    }
  }

  void onSave() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await onCallApi();
      Get.back(result: true);
    }
  }

  @override
  void onClose() {
    codeController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    discountPercentageController.dispose();
    discountAmountController.dispose();
    endDateController.dispose();
    super.onClose();
  }
}