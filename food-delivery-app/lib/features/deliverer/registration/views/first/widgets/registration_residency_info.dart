import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_bottom_navigation_bar.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_dropdown_field.dart';
import 'package:food_delivery_app/common/widgets/registration/registration_text_field.dart';
import 'package:food_delivery_app/features/deliverer/registration/controllers/first/registration_residency_info.dart';
import 'package:get/get.dart';

class RegistrationResidencyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationResidencyInfoController());

    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Obx(() => _buildAddressSection(controller)),
            const SizedBox(height: 20),
            Obx(() => _buildTaxNumberSection(controller)),
            RegistrationTextField(
              label: "Email",
              controller: controller.emailController,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: RegistrationBottomNavigationBar(
        onSave: controller.onSave,
        onContinue: controller.onContinue,
      ),
    );
  }

  Widget _buildAddressSection(RegistrationResidencyInfoController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Địa chỉ tạm trú',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Giống địa chỉ trên CCCD',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              CupertinoSwitch(
                value: controller.isSameAsCI.value,
                onChanged: controller.toggleIsSameAsCI,
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (!controller.isSameAsCI.value) ...[
            Obx(() => RegistrationDropdownField(
              label: 'Tỉnh/Thành phố thường trú (trên CCCD)',
              onChanged: controller.setResidentCity,
              value: controller.city.value,
              items: ["Hà Nội", "TP.HCM", "Đà Nẵng"],
            )),
            Obx(() => RegistrationDropdownField(
              label: 'Quận/Huyện thường trú (trên CCCD)',
              onChanged: controller.setResidentDistrict,
              value: controller.district.value,
              items: ["Quận 1", "Quận 2", "Quận 3"],
            )),
            Obx(() => RegistrationDropdownField(
              label: 'Phường/Xã thường trú (trên CCCD)',
              onChanged: controller.setResidentWard,
              value: controller.ward.value,
              items: ["Phường 1", "Phường 2", "Phường 3"],
            )),
            RegistrationTextField(
              hintText: "0 / 255",
              label: "Địa chỉ thường trú (trên CCCD)",
              controller: controller.addressController,
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int? maxLength}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Nhập $label',
            ),
            maxLength: maxLength,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập $label';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTaxNumberSection(RegistrationResidencyInfoController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormField2(
          'Bạn có mã số thuế TNCN hay không?',
          'Có',
          controller.hasTaxNumber.value,
          controller.toggleHasTaxNumber,
        ),
        if (controller.hasTaxNumber.value)
          _buildTextField('Mã số thuế', controller.taxNumberController),
      ],
    );
  }

  Widget _buildFormField2(
      String label, String value, bool toggleValue, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              CupertinoSwitch(
                value: toggleValue,
                onChanged: onChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
