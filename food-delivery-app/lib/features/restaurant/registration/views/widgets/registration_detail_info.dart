import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/registration_detail_info.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_document_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';

class RegistrationDetailInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationDetailInfoController());

    return Scaffold(
      body: MainWrapper(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                Text(
                  "*Thông tin quán - Chi Tiết",
                  style: Get.textTheme.titleSmall?.copyWith(color: Colors.red),
                ),
                MainWrapper(
                  child: Column(
                    children: controller.isOpen.keys.map((day) {
                      return _buildDayRow(controller, day);
                    }).toList(),
                  ),
                ),

                // Text Fields
                RegistrationTextField(
                  label: 'Từ khóa tìm kiếm',
                  controller: controller.keywordController,
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                RegistrationTextField(
                  label: 'Miêu tả về quán',
                  controller: controller.descriptionController,
                  maxLines: 5,
                  maxLength: 156,
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                // Document Upload Fields
                RegistrationDocumentField(
                  label: "Ảnh đại diện quán",
                  controller: controller.avatarImageController,
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                RegistrationDocumentField(
                  label: "Ảnh bìa",
                  controller: controller.coverImageController,
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                RegistrationDocumentField(
                  label: "Ảnh mặt tiền quán",
                  controller: controller.frontViewController,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: RegistrationBottomNavigationBar(
        onSave: () {
          // Save logic here
        },
        onContinue: () {
          // Continue logic here
        },
      ),
    );
  }

  Widget _buildDayRow(RegistrationDetailInfoController controller, String day) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(day, style: TextStyle(fontSize: 16)),
          ),
          Obx(() => Switch(
            value: controller.isOpen[day]!.value,
            onChanged: (value) {
              controller.isOpen[day]!.value = value;
            },
          )),
          SizedBox(width: TSize.spaceBetweenItemsHorizontal),
          Expanded(
            flex: 3,
            child: Obx(() => controller.isOpen[day]!.value
                ? Row(
              children: [
                _buildTimePicker(controller, day, true),
                Text(' - '),
                _buildTimePicker(controller, day, false),
              ],
            )
                : Text('Đóng cửa', style: TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker(RegistrationDetailInfoController controller, String day, bool isStartTime) {
    final time = isStartTime
        ? controller.operatingHours[day]!.value.start
        : controller.operatingHours[day]!.value.end;

    return InkWell(
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: Get.context!,
          initialTime: time,
        );
        if (pickedTime != null) {
          if (isStartTime) {
            controller.setOperatingHours(day, pickedTime, controller.operatingHours[day]!.value.end);
          } else {
            controller.setOperatingHours(day, controller.operatingHours[day]!.value.start, pickedTime);
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          time.format(Get.context!),
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
