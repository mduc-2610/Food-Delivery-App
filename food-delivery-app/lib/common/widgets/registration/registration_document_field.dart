import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/registration/dotted_border.dart';

class RegistrationDocumentField extends StatelessWidget {
  final String label;
  final int crossAxisCount;
  final double buttonWidth;
  final double? buttonHeight;
  final double imageWidth;
  final double? imageHeight;
  final RegistrationDocumentFieldController controller;

  const RegistrationDocumentField({
    Key? key,
    required this.label,
    this.crossAxisCount = 3,
    this.buttonWidth = 120,
    this.buttonHeight,
    this.imageWidth = 120,
    this.imageHeight,
    required this.controller,
  });

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
          Obx(() => _buildImageSection()),
          const SizedBox(height: 8),
          Row(
            children: [
              SmallButton(
                onPressed: () {},
                text: "Xem ví dụ",
                width: buttonWidth,
                height: buttonHeight,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    if (controller.maxLength == 1 && controller.selectedImages.isNotEmpty) {
      return _buildSingleImageView();
    } else if (controller.maxLength > 1) {
      return _buildMultiImageGrid();
    } else {
      return _buildAddImageButton();
    }
  }

  Widget _buildSingleImageView() {
    dynamic image = controller.selectedImages.first;
    return GestureDetector(
      onTap: () => controller.viewImageDetail(),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(TSize.borderRadiusSm),
            child: image is String
                ? Image.network(
              image,
              height: imageHeight ?? imageWidth,
              width: imageWidth,
              fit: BoxFit.cover,
            )
                : Image.file(
              File(image.path),
              height: imageHeight ?? imageWidth,
              width: imageWidth,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () => controller.removeImage(0),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiImageGrid() {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: controller.selectedImages.length < controller.maxLength
              ? controller.selectedImages.length + 1
              : controller.selectedImages.length,
          itemBuilder: (context, index) {
            if (index == controller.selectedImages.length &&
                controller.selectedImages.length < controller.maxLength) {
              return _buildAddImageButton();
            } else {
              return _buildImageTile(index);
            }
          },
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            "${controller.selectedImages.length}/${controller.maxLength}",
            style: Get.textTheme.bodyLarge,
          ),
        )
      ],
    );
  }

  Widget _buildImageTile(int index) {
    dynamic image = controller.selectedImages[index];
    return InkWell(
      onTap: () => controller.viewImageDetail(index: index),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(TSize.borderRadiusSm),
            child: image is String
                ? Image.network(
              image,
              height: imageHeight ?? imageWidth,
              width: imageWidth,
              fit: BoxFit.cover,
            )
                : Image.file(
              File(image.path),
              height: imageHeight ?? imageWidth,
              width: imageWidth,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () => controller.removeImage(index),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddImageButton() {
    return GestureDetector(
      onTap: () => controller.pickImages(),
      child: DottedBorder(
        strokeWidth: 2,
        color: TColor.disable,
        child: Container(
          height: imageHeight ?? imageWidth,
          width: imageWidth,
          color: Colors.grey.shade200,
          child: const Center(
            child: Text(
              "+ Thêm",
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}
