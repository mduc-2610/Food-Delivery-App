import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/user/order/models/custom_location.dart';
import 'package:food_delivery_app/features/user/order/views/location/location_add.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class PlaceApiService {
  final http.Client client = http.Client();

  Future<List<SuggestionLocation>> fetchSuggestions(String input) async {
    final request = 'https://nominatim.openstreetmap.org/search?q=$input&format=json&addressdetails=1';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final results = json.decode(response.body) as List<dynamic>;
      return results
          .map<SuggestionLocation>((result) => SuggestionLocation(
        result['place_id'].toString(),
        result['display_name'],
      ))
          .toList();
    } else {
      throw Exception('Failed to fetch suggestions');
    }
  }

  Future<dynamic> getPlaceDetailFromId(String placeId) async {
    final request = 'https://nominatim.openstreetmap.org/details?place_id=$placeId&format=json';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      Map<String, dynamic> data = {
        'name': result["localname"] ?? "unknown",
        'latitude': result['centroid']['coordinates'][1],
        'longitude': result['centroid']['coordinates'][0],
      };

      return [data, result];

    } else {
      throw Exception('Failed to fetch place details');
    }
  }
}
