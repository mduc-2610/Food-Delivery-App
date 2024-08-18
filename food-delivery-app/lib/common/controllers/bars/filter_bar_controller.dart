import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class FilterBarController extends GetxController {
  static FilterBarController get instance => Get.find();

  final Rx<String> selectedFilter;

  FilterBarController(String initialFilter)
      : selectedFilter = initialFilter.obs;

  Future<void> onFilterChanged(String filter, Future<void> Function(String) filterChangeCallback) async {
    selectedFilter.value = filter;
    await filterChangeCallback(filter);
  }
}
