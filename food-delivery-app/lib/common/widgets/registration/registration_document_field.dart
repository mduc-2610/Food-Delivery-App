import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/controllers/field/registration_document_field_controller.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/buttons/small_button.dart';
import 'package:food_delivery_app/common/widgets/registration/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class RegistrationDocumentField extends StatelessWidget {
  final String label;
  final bool isSingleImage;
  final int crossAxisCount;
  final VoidCallback onTapAdd;

  RegistrationDocumentField({
    Key? key,
    required this.label,
    required this.onTapAdd,
    this.isSingleImage = true,
    this.crossAxisCount = 3,
  }) : super(key: key);

  final RegistrationDocumentFieldController controller = Get.put(RegistrationDocumentFieldController());
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
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    if (isSingleImage && controller.selectedImages.isNotEmpty) {
      return _buildSingleImageView();
    } else if (!isSingleImage) {
      return _buildMultiImageGrid();
    } else {
      return _buildAddImageButton();
    }
  }

  Widget _buildSingleImageView() {
    return GestureDetector(
      onTap: () => controller.viewImageDetail(),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(TSize.borderRadiusSm),
            child: Image.file(
              File(controller.selectedImages.first.path),
              height: 100,
              width: 100,
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
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: controller.selectedImages.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildAddImageButton();
        } else {
          return _buildImageTile(index - 1);
        }
      },
    );
  }

  Widget _buildImageTile(int index) {
    return InkWell(
      onTap: () => controller.viewImageDetail(index: index),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(TSize.borderRadiusSm),
            child: Image.file(
              File(controller.selectedImages[index].path),
              height: 120,
              width: 120,
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
      onTap: () => controller.pickImages(isSingleImage: isSingleImage),
      child: DottedBorder(
        strokeWidth: 2,
        color: TColor.disable,
        child: Container(
          height: 100,
          width: 100,
          color: Colors.grey.shade200,
          child: const Center(
            child: Text("+ Thêm"),
          ),
        ),
      ),
    );
  }
}