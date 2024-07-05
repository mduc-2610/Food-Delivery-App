import 'package:get/get.dart';

class FilterBarController extends GetxController {
  static FilterBarController get instance => Get.find();

  final Rx<String> selectedFilter;

  FilterBarController(String initialFilter)
      : selectedFilter = initialFilter.obs;

  void onFilterChanged(String filter) {
    selectedFilter.value = filter;
  }
}
