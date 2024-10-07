import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/user/order/controllers/location/location_add_controller.dart';
import 'package:food_delivery_app/features/user/order/models/custom_location.dart';
import 'package:food_delivery_app/features/user/order/views/location/widgets/suggestion_location.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationAddView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrderLocationAddViewContent();
  }
}

class OrderLocationAddViewContent extends StatelessWidget {
  final controller = Get.put(LocationAddController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: 'Add New Location',
      ),
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: controller.addressController,
                decoration: InputDecoration(
                  labelText: 'Search Address',
                  suffixIcon: Icon(Icons.search),
                ),
                maxLines: 2,
                readOnly: true,
                onTap: () async {
                  final SuggestionLocation? result = await showSearch(
                    context: context,
                    delegate: AddressSearch(),
                  );
                  if (result != null && result.placeId.isNotEmpty) {
                    controller.addressController.text = result.description;
                    controller.updateMapLocation(result);
                  }
                },
                validator: (value) => value?.isEmpty ?? true ? 'Search your address' : null,
              ),
            ),
            SizedBox(height: TSize.spaceBetweenItemsVertical),
            Expanded(
              child: Obx(
                    () => GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: controller.selectedLocation,
                    zoom: 14,
                  ),
                  onMapCreated: (GoogleMapController mapController) {
                    controller.setMapController(mapController);
                  },
                  onTap: (LatLng latLng) {
                    controller.updateSelectedLocation(latLng);
                  },
                  markers: controller.markers,
                ),
              ),
            ),
            MainWrapper(
              topMargin: TSize.spaceBetweenSections,
              bottomMargin: TSize.spaceBetweenSections,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.locationNameController,
                    decoration: InputDecoration(labelText: 'Location Name'),
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter a name' : null,
                  ),
                  SizedBox(height: TSize.spaceBetweenInputFields),
                  MainButton(
                    text: 'Save',
                    onPressed: () => controller.saveLocation(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}


