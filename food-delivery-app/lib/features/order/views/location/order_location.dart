import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/order/models/location.dart';
import 'package:food_delivery_app/features/order/views/location/widgets/order_location_list.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:provider/provider.dart';

class OrderLocationSelectView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: "Select Location",
      ),
      body: MainWrapper(
        child: Column(
          children: [
            SizedBox(height: TSize.spaceBetweenItemsVertical,),

            Expanded(
              child: Consumer<LocationModel>(
                builder: (context, locationModel, child) {
                  return LocationList(locations: locationModel.locations);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainWrapper(
        bottomMargin: TSize.spaceBetweenSections,
        child: ElevatedButton(
          child: Text('Apply'),
          onPressed: () {

          }
        ),
      ),
    );
  }
}