import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class FilterBarController extends GetxController {
  static FilterBarController get instance => Get.find();

  final Rx<String> selectedFilter;
  final Future<void> Function(String) filterChangeCallback;
  FilterBarController(String initialFilter, Future<void> Function(String) filterChangeCallback)
      : selectedFilter = initialFilter.obs,
        filterChangeCallback = filterChangeCallback;

  Future<void> onFilterChanged(String filter) async {
    selectedFilter.value = filter;
    await filterChangeCallback(filter);
  }
}
