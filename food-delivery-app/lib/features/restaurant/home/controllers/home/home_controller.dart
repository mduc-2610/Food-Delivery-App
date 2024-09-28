import 'package:food_delivery_app/data/services/api_service.dart';
import 'package:food_delivery_app/data/services/restaurant_service.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/restaurant/home/models/stats.dart';
import 'package:food_delivery_app/features/user/order/models/delivery.dart';
import 'package:food_delivery_app/utils/constants/times.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

enum TimeRange { yearly, monthly, daily }

class RestaurantHomeController extends GetxController {
  static RestaurantHomeController get instance => Get.find();

  Rx<bool> isLoading = true.obs;
  Restaurant? restaurant;
  StatsResponse? statsResponse;
  List<Delivery> deliveries = [];

  Rx<TimeRange> timeRange = TimeRange.yearly.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<int> selectedMonth = DateTime.now().month.obs;
  Rx<int> selectedYear = DateTime.now().year.obs;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    isLoading.value = true;
    restaurant = await RestaurantService.getRestaurant();
    await fetchStats();
    isLoading.value = false;
  }

  Future<void> fetchStats() async {
    String queryParams = _buildQueryParams();
    statsResponse = await APIService<StatsResponse>(
      fullUrl: restaurant?.stats ?? '',
      queryParams: queryParams,
    ).list(single: true);
    update();
  }

  String _buildQueryParams() {
    String queryParams = "time_range=${timeRange.value.toString().split('.').last}";
    switch (timeRange.value) {
      case TimeRange.yearly:
        queryParams += "&year=${selectedYear.value}";
        break;
      case TimeRange.monthly:
        queryParams += "&month=${selectedYear.value}-${selectedMonth.value}";
        break;
      case TimeRange.daily:
        queryParams += "&day=${selectedDate.value.toString().split(' ')[0]}";
        break;
    }
    return queryParams;
  }
  /*
    GET /restaurants/{id}/stats/?time_range=daily
    GET /restaurants/{id}/stats/?time_range=daily&day=2024-04-25
    GET /restaurants/{id}/stats/?time_range=monthly
    GET /restaurants/{id}/stats/?time_range=monthly&month=2024-04
    GET /restaurants/{id}/stats/?time_range=yearly
    GET /restaurants/{id}/stats/?time_range=yearly&year=2023
  */
  Future<void> updateTimeRange(TimeRange newRange) async {
    timeRange.value = newRange;
    await fetchStats();
  }

  Future<void> updateYear(int year) async {
    selectedYear.value = year;
    await fetchStats();
  }

  Future<void> updateMonth(int month) async {
    selectedMonth.value = month;
    await fetchStats();
  }

  Future<void> updateDate(DateTime date) async {
    selectedDate.value = date;
    await fetchStats();
  }
}
