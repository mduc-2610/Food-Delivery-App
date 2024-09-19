import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/common/widgets/dialogs/image_detail_dialog.dart';
import 'package:food_delivery_app/data/services/image_picker_service.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class RegistrationDocumentFieldController extends GetxController {
  final RxList<XFile> selectedImages = <XFile>[].obs;
  final ImagePickerService _imagePickerService = ImagePickerService();

  Future<void> pickImages({ bool isSingleImage = true }) async {
    final List<XFile> pickedImages = await _imagePickerService.pickImages(
      maxImages: isSingleImage ? 1 : 10,
    );
    if (isSingleImage) {
      selectedImages.assignAll(pickedImages);
    } else {
      selectedImages.addAll(pickedImages);
      if (selectedImages.length > 10) {
        selectedImages.removeRange(10, selectedImages.length);
      }
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  void viewImageDetail({ int index = 0}) {
    showDialog(
      context: Get.context!,
      useSafeArea: false,
      barrierColor: TColor.dark.withOpacity(0.1),
      builder: (BuildContext context) => ImageDetailDialog(
        images: selectedImages,
        initialIndex: index,
      ),
    );
  }
}
