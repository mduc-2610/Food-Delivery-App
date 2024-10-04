import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/common/widgets/skeleton/box_skeleton.dart';
import 'package:food_delivery_app/features/restaurant/registration/controllers/category_controller.dart';
import 'package:food_delivery_app/features/user/food/models/food/category.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:food_delivery_app/utils/device/device_utility.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class CategorySelectionSheet extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var controller;
    try {
      controller = CategoryController.instance;
    }
    catch(e) {
      controller = Get.put(CategoryController());
    }
    return Scaffold(
      appBar: CAppBar(
        title: "Choose your category",
        centerTitle: true,
        noLeading: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Column(
            children: List.generate(5, (index) => SkeletonWidget()),
          );
        }
        return Padding(
          padding: EdgeInsets.only(bottom: TSize.spaceBetweenItemsVertical),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount:  controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              return Obx(() {
                int index = controller.selectedCategories.indexWhere((cat) => cat.name == category.name) ;
                // int index2 = controller.disabledCategories.indexWhere((cat) => cat.name == category.name) ;
                bool isSelected = index != -1;
                    // || index2 != -1;
                return ListTile(
                  title: Row(
                    children: [
                      SizedBox(width: TSize.spaceBetweenItemsLg),
                      if (category.image != null) ...[
                        Image.network(
                          category.image,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        )
                      ],
                      SizedBox(width: TSize.spaceBetweenItemsMd),
                      Text(
                        "${category.name}",
                        style: Get.textTheme.bodyMedium?.copyWith(
                          color: isSelected ? Colors.blue : null,
                          fontWeight: isSelected ? FontWeight.bold : null,
                        ),
                      ),
                    ],
                  ),
                  trailing: isSelected
                      ? Padding(
                    padding: EdgeInsets.only(right: TSize.spaceBetweenItemsLg),
                    child: Icon(Icons.check, color: Colors.blue),
                  )
                      : null,
                  tileColor: isSelected ? Colors.blue.withOpacity(0.1) : null,
                  onTap: () => controller.selectCategory(category),
                );
              });
            },
          ),
        );
      }),
    );
  }
}

class SkeletonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      child: Column(
        children: [
          Row(
            children: [
              BoxSkeleton(width: 50, height: 50),
              SizedBox(width: TSize.spaceBetweenItemsHorizontal),
              BoxSkeleton(height: 20, width: TDeviceUtil.getScreenWidth() * 0.75,),
            ],
          ),
          SizedBox(height: TSize.spaceBetweenItemsVertical),

        ],
      ),
    );
  }
}