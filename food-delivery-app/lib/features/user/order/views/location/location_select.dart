import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/cards/container_card.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/order/controllers/location/location_controller.dart';
import 'package:food_delivery_app/features/user/order/views/location/location_add.dart';
import 'package:food_delivery_app/features/user/order/views/location/widgets/order_location_list.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LocationSelectView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationSelectController>(
      init: LocationSelectController(),
      builder: (controller) {
        return Scaffold(
          appBar: CAppBar(
            title: "Select Location",
          ),
          body: MainWrapper(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: TSize.spaceBetweenItemsVertical,),
                if (!controller.isLoading.value)...[
                  Expanded(
                    child: Obx(() => LocationList(
                        locations: controller.userLocations.value
                      )
                    ),
                  ),
                ],
                // Spacer(),
                Container(
                  margin: EdgeInsets.only(bottom: TSize.spaceBetweenItemsVertical),
                  child: ContainerCard(
                    bgColor: TColor.iconBgCancel,
                    borderColor: Colors.transparent,
                    child: ListTile(
                      onTap: controller.handleLocationAdd,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        TIcon.add,
                        color: TColor.primary,
                      ),
                      title: Text(
                        "Add New Location",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TColor.primary),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: MainWrapper(
            bottomMargin: TSize.spaceBetweenSections,
            child: ElevatedButton(
                child: Text('Apply'),
                onPressed: controller.handleApplyLocation,
            ),
          ),
        );
      },
    );
  }
}