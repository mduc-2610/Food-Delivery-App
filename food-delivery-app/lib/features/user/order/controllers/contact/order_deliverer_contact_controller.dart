
import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/user_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/authentication/models/deliverer/deliverer.dart';
import 'package:food_delivery_app/features/user/order/views/contact/order_deliverer_contact.dart';
import 'package:food_delivery_app/features/user/order/views/contact/order_deliverer_contact.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderDelivererContactController extends GetxController {
  static OrderDelivererContactController get instance => Get.find();

  Rx<bool> isLoading = true.obs;
  String? delivererId;
  User? user;
  Deliverer? deliverer;

  OrderDelivererContactController({
    this.user,
    this.deliverer,
  });

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments;
    if(arguments != null) {
      delivererId = arguments["id"];
    }
    initialize();
  }

  Future<void> initialize() async {
    isLoading.value = true;
    if(delivererId != null && deliverer == null) {
      deliverer = deliverer ?? await APIService<Deliverer>().retrieve(delivererId ?? "");
    }
    user = user ?? await UserService.getUser();
    isLoading.value = false;
    update();
  }
}