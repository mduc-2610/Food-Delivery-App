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
  int maxLength = 1;
  final RxList<dynamic> selectedImages = <dynamic>[].obs;
  final ImagePickerService _imagePickerService = ImagePickerService();

  RegistrationDocumentFieldController({
    List<dynamic>? databaseImages,
    int? maxLength,
  }) {
    if (databaseImages != null && databaseImages.isNotEmpty && !databaseImages.contains(null)) {
      selectedImages.addAll(databaseImages);
    }
    this.maxLength = maxLength ?? 1;
  }

  Future<void> pickImages() async {
    final List<dynamic> pickedImages = await _imagePickerService.pickImages(
      maxImages: maxLength,
    );
    if (maxLength == 1) {
      selectedImages.clear();
      selectedImages.assignAll(pickedImages);
    } else {
      selectedImages.addAll(pickedImages);
      if (selectedImages.length > maxLength) {
        selectedImages.removeRange(maxLength, selectedImages.length);
      }
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  void viewImageDetail({int index = 0}) {
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

