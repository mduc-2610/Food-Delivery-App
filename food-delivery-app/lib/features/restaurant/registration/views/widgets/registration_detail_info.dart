import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_document_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:get/get.dart';

class RegistrationDetailInfo extends StatefulWidget {
  @override
  _RegistrationDetailInfoState createState() => _RegistrationDetailInfoState();
}

class _RegistrationDetailInfoState extends State<RegistrationDetailInfo> {
  Map<String, bool> isOpen = {
    'Chủ Nhật': true,
    'Thứ 2': true,
    'Thứ 3': false,
    'Thứ 4': true,
    'Thứ 5': true,
    'Thứ 6': true,
    'Thứ 7': true,
  };

  Map<String, TimeOfDayRange> operatingHours = {
    'Chủ Nhật': TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 22, minute: 0)),
    'Thứ 2': TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 22, minute: 0)),
    'Thứ 3': TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 22, minute: 0)),
    'Thứ 4': TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 22, minute: 0)),
    'Thứ 5': TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 22, minute: 0)),
    'Thứ 6': TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 22, minute: 0)),
    'Thứ 7': TimeOfDayRange(start: TimeOfDay(hour: 9, minute: 0), end: TimeOfDay(hour: 22, minute: 0)),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainWrapper(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: TSize.spaceBetweenItemsVertical,),
          
              Text(
                "*Thông tin quán - Chi Tiết",
                style: Get.textTheme.titleSmall?.copyWith(color: Colors.red),
              ),
              MainWrapper(
                child: Column(
                  children: isOpen.keys.map((day) {
                    return _buildDayRow(day);
                  }).toList(),
                ),
              ),
          
              RegistrationTextField(
                label: 'Tu khoa tim kiem',
                onChanged: (x) {},
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
          
              RegistrationTextField(
                label: 'Mieu ta ve quan',
                onChanged: (x) {},
                maxLines: 5,
                maxLength: 156,
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              RegistrationDocumentField(
                label: "Anh dai dien quan",
                onTapAdd: () {
                },
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              RegistrationDocumentField(
                label: "Anh bia",
                onTapAdd: () {
                },
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

              RegistrationDocumentField(
                label: "Anh mat tien quan",
                onTapAdd: () {
                },
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayRow(String day) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(day, style: TextStyle(fontSize: 16)),
          ),
          Switch(
            value: isOpen[day]!,
            onChanged: (value) {
              setState(() {
                isOpen[day] = value;
              });
            },
          ),
          SizedBox(width: TSize.spaceBetweenItemsHorizontal),
          Expanded(
            flex: 3,
            child: isOpen[day]!
                ? Row(
              children: [
                _buildTimePicker(day, true),
                Text(' - '),
                _buildTimePicker(day, false),
              ],
            )
                : Text('Đóng cửa', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker(String day, bool isStartTime) {
    TimeOfDay time = isStartTime ? operatingHours[day]!.start : operatingHours[day]!.end;

    return InkWell(
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: time,
        );
        if (pickedTime != null) {
          setState(() {
            if (isStartTime) {
              operatingHours[day] = TimeOfDayRange(
                start: pickedTime,
                end: operatingHours[day]!.end,
              );
            } else {
              operatingHours[day] = TimeOfDayRange(
                start: operatingHours[day]!.start,
                end: pickedTime,
              );
            }
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          time.format(context),
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

// A simple helper class to store start and end times
class TimeOfDayRange {
  final TimeOfDay start;
  final TimeOfDay end;

  TimeOfDayRange({required this.start, required this.end});
}
