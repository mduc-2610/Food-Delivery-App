import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/order/models/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

class AddLocationScreen extends StatefulWidget {
  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
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
      appBar: AppBar(
        title: Text('Add New Location'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _locationNameController,
                decoration: InputDecoration(labelText: 'Location Name'),
                onSaved: (value) => _locationNameController.text = value ?? '',
                validator: (value) => value?.isEmpty ?? true ? 'Please enter a name' : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                onSaved: (value) => _addressController.text = value ?? '',
                validator: (value) => value?.isEmpty ?? true ? 'Please enter an address' : null,
              ),
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: _saveLocation,
            ),
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
