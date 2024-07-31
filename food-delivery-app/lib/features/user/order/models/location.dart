import 'package:flutter/foundation.dart';
import 'package:food_delivery_app/data/services/reflect.dart';

@jsonSerializable
class MyLocation {
  final String name;
  final String address;

  MyLocation({required this.name, required this.address});
}

class LocationModel extends ChangeNotifier {
  List<MyLocation> _locations = [
    MyLocation(name: 'Home', address: '221B Baker Street, London, United Kingdom'),
    MyLocation(name: 'Company', address: '1A Baker Street, London, United Kingdom'),
  ];

  List<MyLocation> get locations => _locations;

  void addLocation(MyLocation location) {
    _locations.add(location);
    notifyListeners();
  }
}