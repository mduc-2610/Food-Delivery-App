import 'package:food_delivery_app/data/services/place_api_service.dart';
import 'package:food_delivery_app/features/authentication/models/account/user.dart';
import 'package:food_delivery_app/features/user/order/models/custom_location.dart';
import 'package:food_delivery_app/features/user/order/views/location/location_add.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';

class LocationAddController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rx<LatLng> _selectedLocation = LatLng(20.9805232, 105.7880024).obs;
  RxSet<Marker> _markers = <Marker>{}.obs;
  GoogleMapController? _mapController;
  Map<String, dynamic> chosenLocation = {};

  final TextEditingController locationNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final PlaceApiService _placeApiProvider = PlaceApiService();

  @override
  void onInit() {
    super.onInit();
    _markers.add(
      Marker(
        markerId: MarkerId('selected_location'),
        position: _selectedLocation.value,
      ),
    );
  }

  LatLng get selectedLocation => _selectedLocation.value;
  Set<Marker> get markers => _markers;

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
    animateCameraToSelectedLocation();
  }

  Future<void> animateCameraToSelectedLocation() async {
    if (_mapController != null) {
      await _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _selectedLocation.value,
            zoom: 14,
            tilt: 45,
            bearing: 90,
          ),
        ),
      );
    }
  }

  void updateSelectedLocation(LatLng latLng) {
    _selectedLocation.value = latLng;
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId('selected_location'),
        position: _selectedLocation.value,
      ),
    );
    animateCameraToSelectedLocation();
    updateLocationDetails(latLng);
  }

  Future<void> updateLocationDetails(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        locationNameController.text = place.name ?? '';
        addressController.text = '${place.street}, ${place.locality}, ${place.country}';
      }
    } catch (e) {
      print('Error in reverse geocoding: $e');
    }
  }

  Future<void> updateMapLocation(SuggestionLocation suggestion) async {
    try {
      final [placeDetails, allData] = await _placeApiProvider.getPlaceDetailFromId(suggestion.placeId);
      $print("place_details: $placeDetails");
      final latLng = LatLng(
        THelperFunction.formatDouble(placeDetails['latitude']),
        THelperFunction.formatDouble(placeDetails['longitude']),
      );
      locationNameController.text = placeDetails["name"] ?? "";
      _selectedLocation.value = latLng;

      chosenLocation = {
        "name": locationNameController.text,
        "address": addressController.text,
        "latitude": latLng.latitude,
        "longitude": latLng.longitude,
      };

      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('selected_location'),
          position: _selectedLocation.value,
        ),
      );
      animateCameraToSelectedLocation();
      updateLocationDetails(latLng);
    } catch (e) {
      print('Error updating map location: $e');
    }
  }

  void saveLocation(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      chosenLocation["name"] = locationNameController.text;
      chosenLocation["address"] = addressController.text;
      $print("CHOSEN ${chosenLocation}");
      Get.back(result: chosenLocation);
      locationNameController.text = "";
      addressController.text = "";
    }
  }

  @override
  void onClose() {
    locationNameController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
