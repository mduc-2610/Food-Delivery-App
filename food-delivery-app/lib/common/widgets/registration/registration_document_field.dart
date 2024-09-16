import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/registration/dotted_border.dart';

class RegistrationDocumentField extends StatelessWidget {
  final String label;
  final VoidCallback onTapAdd;

  const RegistrationDocumentField({
    Key? key,
    required this.label,
    required this.onTapAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "*$label",
            style: Get.textTheme.titleSmall?.copyWith(color: Colors.red),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTapAdd,
            child: DottedBorder(
              color: Colors.red,
              strokeWidth: 2,
              child: Container(
                height: 100,
                width: double.infinity,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Text("+ Thêm"),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SmallButton(
                onPressed: () {},
                text: "Xem ví dụ",
              ),
            ],
          )
        ],
      ),
    );
  }
}