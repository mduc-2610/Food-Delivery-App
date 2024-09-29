import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/bars/filter_bar_controller.dart';
import 'package:food_delivery_app/common/widgets/fields/date_picker.dart';
import 'package:food_delivery_app/features/restaurant/home/controllers/home/home_controller.dart';
import 'package:food_delivery_app/utils/constants/enums.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class RevenueTimeFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RestaurantHomeController controller = RestaurantHomeController.instance;

    return Obx(() {
      return Row(
        children: [
          DropdownButton<TimeRange>(
            value: controller.timeRange.value,
            onChanged: (TimeRange? newValue) {
              if (newValue != null) {
                controller.updateTimeRange(newValue);
              }
            },
            items: TimeRange.values.map((TimeRange range) {
              return DropdownMenuItem<TimeRange>(
                value: range,
                child: Text(range.toString().split('.').last.capitalizeFirst!),
              );
            }).toList(),
          ),
          SizedBox(width: 10),
          if (controller.timeRange.value == TimeRange.yearly)
            _buildYearPicker(controller)
          else if (controller.timeRange.value == TimeRange.monthly)
            _buildMonthYearPicker(controller)
          else if (controller.timeRange.value == TimeRange.daily)
              _buildDatePicker(controller),
        ],
      );
    });
  }

  Widget _buildYearPicker(RestaurantHomeController controller) {
    return DropdownButton<int>(
      value: controller.selectedYear.value,
      onChanged: (int? newValue) {
        if (newValue != null) {
          controller.updateYear(newValue);
        }
      },
      items: List<int>.generate(10, (i) => DateTime.now().year - i)
          .map((int year) {
        return DropdownMenuItem<int>(
          value: year,
          child: Text(year.toString()),
        );
      }).toList(),
    );
  }

  Widget _buildMonthYearPicker(RestaurantHomeController controller) {
    return Row(
      children: [
        DropdownButton<int>(
          value: controller.selectedMonth.value,
          onChanged: (int? newValue) {
            if (newValue != null) {
              controller.updateMonth(newValue);
            }
          },
          items: List<int>.generate(12, (i) => i + 1).map((int month) {
            return DropdownMenuItem<int>(
              value: month,
              child: Text(month.toString().padLeft(2, '0')),
            );
          }).toList(),
        ),
        SizedBox(width: 10),
        _buildYearPicker(controller),
      ],
    );
  }

  Widget _buildDatePicker(RestaurantHomeController controller) {
    return SizedBox(
      height: 50,
      width: 150,
      child: CDatePicker(
        labelText: "Choose Date",
        controller: TextEditingController(
          text: controller.selectedDate.value != null
              ? DateFormat('yyyy-MM-dd').format(controller.selectedDate.value!)
              : '',
        ),
        onDateSelected: (date) async {
            final DateTime? picked = await showDatePicker(
              context: Get.context!,
              initialDate: controller.selectedDate.value,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (picked != null && picked != controller.selectedDate.value) {
              controller.updateDate(picked);
            }
        },
      ),
    );
  }
}