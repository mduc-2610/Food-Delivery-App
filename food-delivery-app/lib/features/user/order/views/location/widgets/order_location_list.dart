import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/cards/circle_icon_card.dart';
import 'package:food_delivery_app/common/widgets/cards/container_card.dart';
import 'package:food_delivery_app/common/widgets/misc/radio_tick.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/order/controllers/location/order_location_controller.dart';
import 'package:food_delivery_app/features/user/order/views/location/widgets/location.dart';
import 'package:food_delivery_app/features/user/order/views/location/order_location_add.dart';
import 'package:food_delivery_app/utils/constants/colors.dart';
import 'package:food_delivery_app/utils/constants/icon_strings.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class LocationList extends StatelessWidget {
  final List<dynamic> locations;

  const LocationList({
    Key? key,
    this.locations = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderLocationController>(
      builder: (controller) {
        return ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final location = locations[index];
            return Container(
              margin: EdgeInsets.only(bottom: TSize.spaceBetweenItemsVertical),
              child: InkWell(
                  onTap: () {
                    controller.selectLocation(index);
                  },
                  child: ContainerCard(
                    borderColor: controller.selectedIndex.value == index ? TColor.disable : TColor.borderPrimary,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "${location?.name ?? "Home"}",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: controller.selectedIndex.value == index
                              ? Theme.of(context).textTheme.titleLarge?.color
                              : TColor.disable,
                        ),
                      ),
                      subtitle: Text(
                        "${location?.addressController}",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: controller.selectedIndex.value == index
                              ? Theme.of(context).textTheme.titleSmall?.color
                              : TColor.disable,
                        ),
                      ),
                      trailing:
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleIconCard(
                              icon: Icons.edit,
                              iconColor: TColor.light,
                              backgroundColor: TColor.primary,
                            ),

                            CircleIconCard(
                              icon: Icons.delete,
                              iconColor: TColor.light,
                              backgroundColor: TColor.primary,
                            ),
                          ],
                        ),
                      )
                      // RadioTick(
                      //   value: index,
                      //   groupValue: controller.selectedIndex.value,
                      //   onChanged: (value) {
                      //     controller.selectLocation(value);
                      //   },
                      // ),
                    ),
                  )
              ),
            );
          },
        );
      },
    );
  }
}

