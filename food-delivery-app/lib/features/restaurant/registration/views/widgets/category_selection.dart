import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/features/restaurant/registration/views/widgets/category_selection_sheet.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/image_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/constants/variable.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/features/authentication/models/restaurant/restaurant.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/category_controller.dart';

class CategorySelection extends StatelessWidget {
  final Restaurant? restaurant;
  final VoidCallback? onSave;

  const CategorySelection({
    super.key,
    this.restaurant,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    var categoryController;
    try {
      categoryController = CategoryController.instance;
    }
    catch (e) {
      categoryController = Get.put(CategoryController(restaurant: restaurant));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainButton(
          backgroundColor: TColor.secondary,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => CategorySelectionSheet(),
            );
          },
          text: 'Select Categories',
          borderColor: TColor.secondary,
        ),
        SizedBox(height: TSize.spaceBetweenItemsVertical),

        Column(
          children: [
            Obx(() {
              return Wrap(
                spacing: 8,
                children: categoryController.selectedCategories
                    .map<Widget>((category) {
                  return Chip(
                    label: Text(
                      "${category.name}",
                      style: Get.textTheme.bodyMedium,
                    ),
                    avatar: (category.image != null)
                        ? Image.network(category.image, width: 30, height: 30)
                        : Image.asset(TImage.hcBurger1),
                    deleteIcon: Icon(Icons.close),
                    onDeleted: () => categoryController.removeCategory(category),
                  );
                }).toList(), // Explicitly casting to a list of Widget
              );
            }),
          ],
        ),
        SizedBox(height: TSize.spaceBetweenItemsVertical),

        Obx(() => (categoryController.disabledCategories.isNotEmpty) ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Disabled categories",
              style: Get.theme.textTheme.titleMedium,
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
          ],
        )
            : SizedBox.shrink()),

        Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                children: categoryController.disabledCategories
                    .map<Widget>((category) {
                  return Chip(
                    label: Text(
                      "${category.name}",
                      style: Get.textTheme.bodyMedium,
                    ),
                    avatar: (category.image != null)
                        ? Image.network(category.image, width: 30, height: 30)
                        : Image.asset(TImage.hcBurger1),
                    deleteIcon: Icon(Icons.close),
                    onDeleted: () => categoryController.removeCategory(category),
                  );
                }).toList(), // Explicitly casting to a list of Widget
              ),
              SizedBox(height: TSize.spaceBetweenItemsVertical),
            ],
          );
        }),

        Text(
          "You are only allowed to have a maximum of ${TVar.activeCategories} active categories at any given time. If you attempt to add more than 5, please remove one of the existing active categories before adding a new one.",
          style: Get.theme.textTheme.bodyMedium?.copyWith(color: TColor.textDesc),
        ),
        SizedBox(height: TSize.spaceBetweenItemsVertical),

        if(onSave != null)...[
          MainButton(
            onPressed: () async {
              onSave?.call();
              await categoryController.onSave();
              Get.back(result: true);
            },
            text: 'Save',
          ),
        ]
      ],
    );
  }
}
