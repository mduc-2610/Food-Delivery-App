import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@reflector
@jsonSerializable
class BaseLocation {
  final String? id;
  final String? address;
  final double latitude;
  final double longitude;
  final String? name;
  final bool isSelected;

  BaseLocation({
    this.id,
    this.address,
    this.latitude = 0,
    this.longitude = 0,
    this.name,
    this.isSelected = false,
  });

  BaseLocation.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        address = json['address'],
        latitude = THelperFunction.formatDouble(json['latitude']),
        longitude = THelperFunction.formatDouble(json['longitude']),
        name = json['name'],
        isSelected = json['is_selected'] ?? false;

  Map<String, dynamic> toJson({bool patch = false}) {
    final map = {
      'id': id,
      'address': address,
      'latitude': latitude.toStringAsFixed(6),
      'longitude': longitude.toStringAsFixed(6),
      'name': name,
      'is_selected': isSelected,
    };

    if (patch) {
      map.removeWhere((key, value) => value == null);
    }

    return map;
  }

  LatLng get currentCoordinate {
    return LatLng(latitude, longitude);
  }

  @override
  String toString() {
    return THelperFunction.formatToString(this);
  }
}


class SuggestionLocation {
  final String placeId;
  final String description;

  SuggestionLocation(this.placeId, this.description);
}
