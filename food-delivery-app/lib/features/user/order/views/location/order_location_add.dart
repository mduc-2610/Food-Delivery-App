import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/widgets/app_bar/app_bar.dart';
import 'package:food_delivery_app/common/widgets/buttons/main_button.dart';
import 'package:food_delivery_app/common/widgets/misc/main_wrapper.dart';
import 'package:food_delivery_app/features/user/order/models/location.dart';
import 'package:food_delivery_app/utils/constants/sizes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

class OrderLocationAddView extends StatefulWidget {
  @override
  _OrderLocationAddViewState createState() => _OrderLocationAddViewState();
}

class _OrderLocationAddViewState extends State<OrderLocationAddView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  LatLng _selectedLocation = LatLng(51.5074, -0.1278);

  @override
  void dispose() {
    _locationNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
          title: 'Add New Location'
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: TSize.spaceBetweenItemsVertical,),

            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _selectedLocation,
                  zoom: 14,
                ),
                onTap: (LatLng latLng) {
                  setState(() {
                    _selectedLocation = latLng;
                  });
                  _updateLocationDetails(latLng);
                },
                markers: {
                  Marker(
                    markerId: MarkerId('selected_location'),
                    position: _selectedLocation,
                  ),
                },
              ),
            ),
            MainWrapper(
              topMargin: TSize.spaceBetweenSections,
              bottomMargin: TSize.spaceBetweenSections,
              child: Column(
                children: [
                  TextFormField(
                    controller: _locationNameController,
                    decoration: InputDecoration(labelText: 'Location Name'),
                    onSaved: (value) => _locationNameController.text = value ?? '',
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter a name' : null,
                  ),
                  SizedBox(height: TSize.spaceBetweenInputFields,),

                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                    onSaved: (value) => _addressController.text = value ?? '',
                    validator: (value) => value?.isEmpty ?? true ? 'Please enter an address' : null,
                  ),
                  SizedBox(height: TSize.spaceBetweenInputFields,),

                  MainButton(
                    text: 'Save',
                    onPressed: _saveLocation,
                  ),],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _updateLocationDetails(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _locationNameController.text = place.name ?? '';
          _addressController.text = '${place.street}, ${place.locality}, ${place.country}';
        });
      }
    } catch (e) {
      print('Error in reverse geocoding: $e');
    }
  }

  void _saveLocation() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final locationModel = Provider.of<LocationModel>(context, listen: false);
      locationModel.addLocation(MyLocation(
        name: _locationNameController.text,
        address: _addressController.text,
      ));
      Navigator.pop(context);
    }
  }
}
