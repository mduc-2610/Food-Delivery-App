import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/registration_detail_info.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:food_delivery_app/utils/objects/objects.dart';
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
                    children: controller.operatingHours.keys.map((day) {
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

                RegistrationTextField(
                  label: 'Loại nhà hàng',
                  controller: controller.restaurantTypeController,
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                RegistrationTextField(
                  label: 'Ẩm thực',
                  controller: controller.cuisineController,
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                RegistrationTextField(
                  label: 'Món đặc trưng',
                  controller: controller.specialtyDishesController,
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                RegistrationTextField(
                  label: 'Thời gian phục vụ',
                  controller: controller.servingTimesController,
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                RegistrationTextField(
                  label: 'Đối tượng khách hàng',
                  controller: controller.targetAudienceController,
                ),
                SizedBox(height: TSize.spaceBetweenItemsVertical),

                RegistrationTextField(
                  label: 'Mục đích',
                  controller: controller.purposeController,
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
                  controller: controller.facadeImageController,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: RegistrationBottomNavigationBar(
        onSave: controller.onSave,
        onContinue: controller.onContinue,
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
            value: controller.operatingHours[day]!.isNotEmpty,
            onChanged: (value) => controller.toggleOperatingHours(day, value),
          )),
          SizedBox(width: TSize.spaceBetweenItemsHorizontal),
          Expanded(
            flex: 3,
            child: Obx(() => controller.operatingHours[day]!.isNotEmpty
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
    return Obx(() {
      final time = isStartTime
          ? controller.operatingHours[day]!.first.start
          : controller.operatingHours[day]!.first.end;

      return InkWell(
        onTap: () => controller.updateOperatingHours(day, isStartTime),
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
    });
  }
}